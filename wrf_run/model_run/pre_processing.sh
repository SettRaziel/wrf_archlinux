#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-07 19:02:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-07-01 17:24:21

# Script to start the model run
# $1: the path to the wrf root folder

# define terminal colors
source ../terminal_color.sh

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting wrf run at ${now}.\n" >> ${SCRIPT_PATH}/../log.info

printf "${YELLOW}starting wrf run ... ${NC}\n"
cd ${BUILD_PATH}/WRFV3/test/em_real
mpirun ./wrf.exe

# logging time stamp
now=$(date +"%T")
printf "Finished wrf run at ${now}.\n" >> ${SCRIPT_PATH}/../log.info
