#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-06-20 16:23:49

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

BUILD_PATH=${1}
GFS_PATH=${2}
RESOLUTION=${3}

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

# starting preprocessing steps
now=$(date +"%T")
printf "Starting preprocessing at ${now}.\n" >> ${SCRIPT_PATH}/../log.info

# opening wps folder
cd ${BUILD_PATH}/WPS

# preprocessing static data: elevation data and geo data
printf "${YELLOW}preprocessing static data (geogrid.exe): ${NC}\n"
./geogrid.exe > ${SCRIPT_PATH}/../debug.log

# processing initial data and boundary data
printf "${YELLOW}preprocessing initial and boundary data: ${NC}\n"
./link_grib.csh ${GFS_PATH}/gfs.*.pgrb2.${RESOLUTION}.f*
ln -sf ungrib/Variable_Tables/Vtable.GFS ./Vtable
LD_LIBRARY_PATH=$DIR/grib2/lib ./ungrib.exe >> ${SCRIPT_PATH}/../debug.log
./metgrid.exe >> ${SCRIPT_PATH}/../debug.log

# vertical interpolation preprocessing
printf "${YELLOW}doing vertical interpolation (real.exe): ${NC}\n"
cd ${BUILD_PATH}/WRFV3/test/em_real
ln -sf ../../../WPS/met_em.* .
./real.exe
cp rsl.error.0000 real_error.log

cd ${SCRIPT_PATH}
sh ./pre_processing.sh