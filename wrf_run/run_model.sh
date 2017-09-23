#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-09-23 13:51:52

# main script for starting a wrf model run
# Version 0.1.0
# created by Benjamin Held and other sources, June 2017
# $1: the starting hour of the model run

function error_exit () {
  now=$(date +"%T")
  ERROR_STATUS="${1} at: ${now}."
  printf "${ERROR_STATUS}\n" >> ${ERROR_LOG}
  printf "Error: ${1} at: ${now}.\n" >> ${STATUS_FILE}
  cd ${SCRIPT_PATH}
  echo "${1}" 1>&2
  exit 1
}

# imports
source ${SCRIPT_PATH}/set_env.sh

# default variables
GFS_PATH=${HOME}/gfs_data
SCRIPT_PATH=${HOME}/scripts
BUILD_PATH=${HOME}/Build_WRF
STATUS_FILE=./status.log                     # customize path if required
ERROR_LOG=${SCRIPT_PATH}/error_$(date +"%m_%d").log # path to error log

if [ "$#" -eq 3 ]; then # no argument, run whole script
  YEAR=`date '+%Y'`
  MONTH=`date '+%m'`
  DAY=`date '+%d'`
  HOUR=${1}
  PERIOD=${2}
  RESOLUTION=${3}
elif [ "$#" -eq 6 ]; then
  YEAR=${1}
  MONTH=${2}
  DAY=${3}
  HOUR=${4}
  PERIOD=${5}
  RESOLUTION=${6}
else
  echo "Wrong number of arguments."
  echo "Must either be two for <HOUR> <PERIOD> or five for <YEAR> <MONTH> <DAY> <HOUR> <PERIOD>"
  exit 1
fi

# adjusting namelist for next run
cd ${SCRIPT_PATH}/model_run
printf "Starting namelist preparation.\n" >> ${STATUS_FILE}
sh prepare_namelist.sh ${BUILD_PATH} ${YEAR} ${MONTH} ${DAY} ${HOUR} ${PERIOD}; ret=${?}
if ! [ ${ret} == 0 ]; then
  error_exit "Failed to prepare the namelist files"
fi

# fetching input data
cd ${SCRIPT_PATH}/data_fetch
printf "Starting namelist preparation.\n" >> ${STATUS_FILE}
sh gfs_fetch.sh "${YEAR}${MONTH}${DAY}" ${HOUR} ${GFS_PATH} ${RESOLUTION} ${PERIOD}; ret=${?}
if ! [ ${ret} == 0 ]; then
  error_exit "Failed to prepare the namelist files"
fi

# start model run
cd ${SCRIPT_PATH}/model_run
printf "Starting model run and preparation.\n" >> ${STATUS_FILE}
sh run_preprocessing.sh ${BUILD_PATH} ${GFS_PATH} ${RESOLUTION}; ret=${?}
cd ${SCRIPT_PATH}
if ! [ ${ret} == 0 ]; then
    cd ${BUILD_PATH}/WRFV3/test/em_real/
    rm wrfout_d01_*
    error_exit "Failed to run the model"
fi

# move output files
cd ${SCRIPT_PATH}/model_run
sh clean_up_output.sh
mv ${BUILD_PATH}/WRFV3/test/em_real/wrfout_d01_* ${HOME}/wrf_output

# run output script
cd ${SCRIPT_PATH}
printf "Starting postprocessing.\n" >> ${STATUS_FILE}
sh draw_plots.sh ${YEAR} ${MONTH} ${DAY} ${HOUR} ${PERIOD}; ret=${?}
if [ ${ret} == 0 ]; then
  printf "Starting archive generation.\n" >> ${STATUS_FILE}
  cd ${HOME}/wrf_output
  tar czf wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz wrfout_d01_* Han.d01.* Ith.d01.*
  mv wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz history/
else
    error_exit "Error while creating output files"
fi

printf "Finished model run without error.\n" >> ${STATUS_FILE}
