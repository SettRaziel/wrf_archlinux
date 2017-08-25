#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-15 18:22:35
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-08-25 17:55:08

# script to update the input parameter for a model run
# $1: the path to the wrf root folder
# $2: the year for the model run
# $3: the month for the model run
# $4: the day for the model run
# $5: the hour of the model run
# $6: the timespan for the model run

set -e

# define terminal colors
source ../terminal_color.sh

# error handling for input parameter
if [ "$#" -ne 6 ]; then
  echo "Wrong number of arguments. Must be one for <BUILD_PATH> <YEAR> <MONTH> <DAY> <HOUR> <PERIOD>."
  exit 1
fi

# Use the correct build path
BUILD_PATH=${1}

# Setting start conditions
START_YEAR=${2}
START_MONTH=${3}
START_DAY=${4}
START_HOUR=${5}
PERIOD=${6}

END_HOUR=`date '+%H' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +${PERIOD} hours"`
END_YEAR=`date '+%Y' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +${PERIOD} hours"`
END_MONTH=`date '+%m' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +${PERIOD} hours"`
END_DAY=`date '+%d' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +${PERIOD} hours"`

# calculating run time
RUN_DAYS=`expr ${PERIOD} / 24`
RUN_HOURS=`expr ${PERIOD} % 24`

# grid parameters
DT=80
DX=10000
DY=10000

GRID_X=300
GRID_Y=300

printf "${YELLOW}\nSetting start date to: ${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR}:00${NC}\n"
printf "${YELLOW}\nSetting end date to: ${END_YEAR}-${END_MONTH}-${END_DAY} ${END_HOUR}:00${NC}\n"
printf "${YELLOW}\nForcasting for: ${RUN_DAYS} days and ${RUN_HOURS} hours${NC}\n"
printf "${YELLOW}\nSetting grid to $GRID_X x $GRID_Y${NC}\n"
printf "${YELLOW}\nSetting step size to $DX x $DY${NC}\n"
printf "${YELLOW}\nSetting time step $DT${NC}\n"

# Adjust values in namelist.wps in the wps folder
cd ${BUILD_PATH}/WPS
sed -r -i "s/start_date = '[0-9]+\-[0-9]+\-[0-9]+\_[0-9]+/start_date = '${START_YEAR}\-${START_MONTH}\-${START_DAY}\_${START_HOUR}/g" namelist.wps
sed -r -i "s/end_date   = '[0-9]+\-[0-9]+\-[0-9]+\_[0-9]+/end_date   = '${END_YEAR}\-${END_MONTH}\-${END_DAY}\_${END_HOUR}/g" namelist.wps

sed -r -i "s/e\_we              =  [0-9]+/e\_we              =  ${GRID_X}/g" namelist.wps
sed -r -i "s/e\_sn              =  [0-9]+/e\_sn              =  ${GRID_Y}/g" namelist.wps

sed -r -i "s/dx = [0-9]+/dx = ${DX}/g" namelist.wps
sed -r -i "s/dy = [0-9]+/dy = ${DY}/g" namelist.wps

# Adjust values in namelist.input in the wrf folder
cd ${BUILD_PATH}/WRFV3/test/em_real

sed -r -i "s/run_days                            = [0-9]+/run_days                            = ${RUN_DAYS}/g" namelist.input
sed -r -i "s/run_hours                           = [0-9]+/run_days                            = ${RUN_HOURS}/g" namelist.input

sed -r -i "s/start_year                          = [0-9]+/start_year                          = ${START_YEAR}/g" namelist.input
sed -r -i "s/start_month                         = [0-9]+/start_month                         = ${START_MONTH}/g" namelist.input
sed -r -i "s/start_day                           = [0-9]+/start_day                           = ${START_DAY}/g" namelist.input
sed -r -i "s/start_hour                          = [0-9]+/start_hour                          = ${START_HOUR}/g" namelist.input

sed -r -i "s/end_year                            = [0-9]+/end_year                            = ${END_YEAR}/g" namelist.input
sed -r -i "s/end_month                           = [0-9]+/end_month                           = ${END_MONTH}/g" namelist.input
sed -r -i "s/end_day                             = [0-9]+/end_day                             = ${END_DAY}/g" namelist.input
sed -r -i "s/end_hour                            = [0-9]+/end_hour                            = ${END_HOUR}/g" namelist.input

sed -r -i "s/e\_we                                = [0-9]+/e\_we                                = ${GRID_X}/g" namelist.input
sed -r -i "s/e\_sn                                = [0-9]+/e\_sn                                = ${GRID_Y}/g" namelist.input

sed -r -i "s/time_step                           = [0-9]+/time_step                           = ${DT}/g" namelist.input
sed -r -i "s/dx                                  = [0-9]+/dx                                  = ${DX}/g" namelist.input
sed -r -i "s/dy                                  = [0-9]+/dy                                  = ${DY}/g" namelist.input
