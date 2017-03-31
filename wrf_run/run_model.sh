#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-31 18:44:36

GFS_PATH=${HOME}/gfs_data
SCRIPT_PATH=${HOME}/scripts

source ${SCRIPT_PATH}/set_env.sh

DATE_VALUE=`date '+%F-%H'`
IFS='-' read -ra DATE_ARRAY <<< "${DATE_VALUE}"
YEAR=${DATE_ARRAY[0]}
MONTH=${DATE_ARRAY[1]}
DAY=${DATE_ARRAY[2]}
HOUR=$1

# adjusting namelist for next run
cd $SCRIPT_PATH
sh prepare_namelist.sh ${YEAR} ${MONTH} ${DAY} ${HOUR}

# fetching input data
cd $SCRIPT_PATH
sh gfs_fetch.sh "${YEAR}${MONTH}${DAY}" $HOUR $GFS_PATH

# start model run
cd $SCRIPT_PATH
sh pre_processing.sh ${HOME}/Build_WRF $GFS_PATH

# move output files
rm ${HOME}/wrf_output/wrfout_d01_*
rm ${HOME}/wrf_output/Han.*
mv ${HOME}/Build_WRF/WRFV3/test/em_real/wrfout_d01_* ${HOME}/wrf_output
mv ${HOME}/Build_WRF/WRFV3/test/em_real/Han.* ${HOME}/wrf_output
