#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 16:04:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-04-14 19:32:58

source ${HOME}/scripts/set_env.sh

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting output generation at ${now}.\n" >> ${SCRIPT_PATH}/log.info

YEAR=${1}
MONTH=${2}
DAY=${3}
HOUR=${4}
PERIOD=${5}
# optional addition to the storage path
DEST_SUFFIX='_test'

# create parent folder for time stamp
mkdir ./${MONTH}_${DAY}_${HOUR}

# generate all listed meteograms
cd ${SCRIPT_PATH}
sh ./draw_meteograms.sh ${YEAR} ${MONTH} ${DAY} ${HOUR} ${PERIOD} ${DEST_SUFFIX}

cd ${HOME}/wrf_output

# generate output
ncl plot_timestamp_output >> ${SCRIPT_PATH}/debug.log
ncl plot_tot_rain >> ${SCRIPT_PATH}/debug.log

find . -maxdepth 1 -name '*.png' -exec optipng {} \;

# create folder and move output
mkdir ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/comp
mkdir ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/rain_3h
mkdir ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/rain_tot
mkdir ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/thunderstorm_index

mv comp_*.png ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/comp
mv rain_3h_*.png ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/rain_3h
mv rain_tot_*.png ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/rain_tot
mv thunderstorm_*.png ./${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}/thunderstorm_index

# logging time stamp
now=$(date +"%T")
printf "Finished output generation at ${now}.\n" >> ${SCRIPT_PATH}/log.info
