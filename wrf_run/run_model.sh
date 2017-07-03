#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-07-03 17:53:49

# main script for starting a wrf model run
# Version 0.1.0
# created by Benjamin Held and other sources, June 2017
# $1: the starting hour of the model run

function error_exit {
  now=$(date +"%T")
  printf "${1} at: ${now}.\n" >> ${SCRIPT_PATH}/error.log
  printf "Error: ${1} at: ${now}.\n" >> ${STATUS_FILE}
  echo "${1}" 1>&2
  exit 1
}

# imports
source ${SCRIPT_PATH}/set_env.sh

# default variables
GFS_PATH=${HOME}/gfs_data
SCRIPT_PATH=${HOME}/scripts
BUILD_PATH=${HOME}/Build_WRF
STATUS_FILE=./status.log      # customize path if required
PERIOD=180                    # the time period of the forecast
RESOLUTION="0p50"             # the resolution of the input data

# error handling for input parameter
if [ "$#" -eq 1 ]; then
  YEAR=`date '+%Y'`
  MONTH=`date '+%m'`
  DAY=`date '+%d'`
  HOUR=${1}
elif [ "$#" -eq 4 ]; then
  YEAR=${1}
  MONTH=${2}
  DAY=${3}
  HOUR=${4}
else
  echo "Wrong number of arguments."
  echo "Must either be one for <HOUR> or four for <YEAR> <MONTH> <DAY> <HOUR>"
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
    error_exit "Failed to run the model"
fi

# move output files
cd ${SCRIPT_PATH}/model_run
sh clean_up_output.sh
mv ${BUILD_PATH}/WRFV3/test/em_real/wrfout_d01_* ${HOME}/wrf_output
mv ${BUILD_PATH}/WRFV3/test/em_real/Han.* ${HOME}/wrf_output

# run output script
cd ${SCRIPT_PATH}/post_processing
sh draw_plots.sh ${YEAR} ${MONTH} ${DAY} ${HOUR}
sh create_ini.sh ${YEAR} ${MONTH} ${DAY} ${HOUR} ${PERIOD}
