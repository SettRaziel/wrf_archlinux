#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-15 18:22:35
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-25 22:38:53

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Setting start conditions
START_YEAR=$1
START_MONTH=$2
START_DAY=$3
START_HOUR=$4

END_YEAR=''
END_MONTH=''
END_DAY=''
END_HOUR=''

DT=100
DX=10000
DY=10000

GRID_X=300
GRID_Y=300

# calculating end date
END_DATE=`date '+%F %H' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +180 hours"`
IFS=' ' read -ra DATE_ARRAY <<< "$END_DATE"
END_HOUR=${DATE_ARRAY[1]}
IFS='-' read -ra DATE_ARRAY <<< "${DATE_ARRAY[0]}"
END_YEAR=${DATE_ARRAY[0]}
END_MONTH=${DATE_ARRAY[1]}
END_DAY=${DATE_ARRAY[2]}

printf "${YELLOW}\nSetting start date to: ${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR}:00${NC}\n"
printf "${YELLOW}\nSetting end date to: ${END_YEAR}-${END_MONTH}-${END_DAY} ${END_HOUR}:00${NC}\n"
printf "${YELLOW}\nSetting grid to $GRID_X x $GRID_Y${NC}\n"
printf "${YELLOW}\nSetting step size to $DX x $DY${NC}\n"
printf "${YELLOW}\nSetting time step $DT x $DY${NC}\n"

# Adjust values in namelist.wps in the wps folder
cd ${HOME}/Build_WRF/WPS
sed -r -i "s/start_date = '[0-9]+\-[0-9]+\-[0-9]+\_[0-9]+/start_date = '$START_YEAR\-$START_MONTH\-$START_DAY\_$START_HOUR/g" namelist.wps
sed -r -i "s/end_date   = '[0-9]+\-[0-9]+\-[0-9]+\_[0-9]+/end_date   = '$END_YEAR\-$END_MONTH\-$END_DAY\_$END_HOUR/g" namelist.wps

sed -r -i "s/e\_we              =  [0-9]+/e\_we              =  $GRID_X/g" namelist.wps
sed -r -i "s/e\_sn              =  [0-9]+/e\_sn              =  $GRID_Y/g" namelist.wps

sed -r -i "s/dx = [0-9]+/dx = $DX/g" namelist.wps
sed -r -i "s/dy = [0-9]+/dy = $DY/g" namelist.wps

# Adjust values in namelist.input in the wrf folder
cd ${HOME}/Build_WRF/WRFV3/test/em_real
sed -r -i "s/start_year                          = [0-9]+/start_year                          = $START_YEAR/g" namelist.input
sed -r -i "s/start_month                         = [0-9]+/start_month                         = $START_MONTH/g" namelist.input
sed -r -i "s/start_day                           = [0-9]+/start_day                           = $START_DAY/g" namelist.input
sed -r -i "s/start_hour                          = [0-9]+/start_hour                          = $START_HOUR/g" namelist.input

sed -r -i "s/end_year                            = [0-9]+/end_year                            = $END_YEAR/g" namelist.input
sed -r -i "s/end_month                           = [0-9]+/end_month                           = $END_MONTH/g" namelist.input
sed -r -i "s/end_day                             = [0-9]+/end_day                             = $END_DAY/g" namelist.input
sed -r -i "s/end_hour                            = [0-9]+/end_hour                            = $END_HOUR/g" namelist.input

sed -r -i "s/time_step                           = [0-9]+/time_step                           = $DT/g" namelist.input
sed -r -i "s/dx                                  = [0-9]+/dx                                  = $DX/g" namelist.input
sed -r -i "s/dy                                  = [0-9]+/dy                                  = $DY/g" namelist.input
