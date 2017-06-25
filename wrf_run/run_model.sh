#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-06-25 17:19:03

# main script for starting a wrf model run
# $1: the starting hour of the model run

# imports
source ${SCRIPT_PATH}/set_env.sh

# default variables
GFS_PATH=${HOME}/gfs_data
SCRIPT_PATH=${HOME}/scripts
BUILD_PATH=${HOME}/Build_WRF
PERIOD=180                    # the time period of the forecast
RESOLUTION="0p50"             # the resolution of the input data

# error handling for input parameter
if [ "$#" -ne 1 ]; then
  echo "Wrong number of arguments. Must be one for <HOUR>."
  exit 1
fi

# determine start date
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
HOUR=${1}

# adjusting namelist for next run
cd ${SCRIPT_PATH}/model_run
sh prepare_namelist.sh ${BUILD_PATH} ${YEAR} ${MONTH} ${DAY} ${HOUR} ${PERIOD}

# fetching input data
cd ${SCRIPT_PATH}/data_fetch
sh gfs_fetch.sh "${YEAR}${MONTH}${DAY}" ${HOUR} ${GFS_PATH} ${RESOLUTION} ${PERIOD}

# start model run
cd ${SCRIPT_PATH}/model_run
sh run_preprocessing.sh ${BUILD_PATH} ${GFS_PATH} ${RESOLUTION}

# move output files
cd ${SCRIPT_PATH}/model_run
sh clean_up_output.sh
mv ${BUILD_PATH}/WRFV3/test/em_real/wrfout_d01_* ${HOME}/wrf_output
mv ${BUILD_PATH}/WRFV3/test/em_real/Han.* ${HOME}/wrf_output

# run output script
cd ${SCRIPT_PATH}/post_processing
sh draw_plots.sh ${YEAR} ${MONTH} ${DAY} ${HOUR}
sh create_ini.sh ${YEAR} ${MONTH} ${DAY} ${HOUR} ${PERIOD}
