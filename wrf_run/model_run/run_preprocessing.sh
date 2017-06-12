#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-06-12 19:24:21

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

BUILD_PATH=${1}
GFS_PATH=${2}

source ../set_env.sh

# cleaning up in wps preprocessing folder
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Cleaning up wps data from last time at ${now}\n" >> ${SCRIPT_PATH}/../log.info
cd ${BUILD_PATH}/WPS

# remove met_em files from the last run
rm met_em.d01.*

# remove grib files
rm GRIB*

# remove FILE objects of the time stamps
rm FILE*
rm PFILE*

# cleaning up in wrf
now=$(date +"%T")
printf "Cleaning up wrf data from last time at ${now}\n" >> ${SCRIPT_PATH}/../log.info
cd ${BUILD_PATH}/WRFV3/test/em_real/

# remove met_em files from the last run
rm met_em.d01.*

cd ${SCRIPT_PATH}
sh ./pre_processing.sh ${BUILD_PATH} ${GFS_PATH}
