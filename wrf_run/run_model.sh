#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-06-07 19:46:04

GFS_PATH=${HOME}/gfs_data
SCRIPT_PATH=${HOME}/scripts

source ${SCRIPT_PATH}/set_env.sh

if [ "$#" -ne 1 ]; then # no argument, run whole script
  echo "Wrong number of arguments. Must be one for <HOUR>."
  exit 1
fi

YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
HOUR=${1}

# adjusting namelist for next run
cd ${SCRIPT_PATH}
sh prepare_namelist.sh ${YEAR} ${MONTH} ${DAY} ${HOUR}

# fetching input data
cd ${SCRIPT_PATH}
sh gfs_fetch.sh "${YEAR}${MONTH}${DAY}" ${HOUR} ${GFS_PATH}

# start model run
cd ${SCRIPT_PATH}
sh run_preprocessing.sh ${HOME}/Build_WRF ${GFS_PATH}

# move output files
cd ${SCRIPT_PATH}
sh clean_up_output.sh
mv ${HOME}/Build_WRF/WRFV3/test/em_real/wrfout_d01_* ${HOME}/wrf_output
mv ${HOME}/Build_WRF/WRFV3/test/em_real/Han.* ${HOME}/wrf_output

# run output script
cd ${SCRIPT_PATH}
sh draw_plots.sh ${YEAR} ${MONTH} ${DAY} ${HOUR}
sh create_ini.sh ${YEAR} ${MONTH} ${DAY} ${HOUR} ${PERIOD}
