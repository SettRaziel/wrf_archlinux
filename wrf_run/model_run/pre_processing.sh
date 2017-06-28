#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-07 19:02:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-06-28 20:35:12

# Script to start the model run
# $1: the path to the wrf root folder

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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
