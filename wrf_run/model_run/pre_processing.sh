#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-07 19:02:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-03-02 21:10:27

# Script to start the model run
# $1: the path to the wrf root folder

set -e

# define terminal colors
source ../../libs/terminal_color.sh

# variable declaration
GFS_PATH=${1}
RESOLUTION=${2}

# starting preprocessing steps
now=$(date +"%T")
printf "Starting preprocessing at ${now}.\n" >> ${LOG_PATH}/log.info

# opening wps folder
cd ${BUILD_PATH}/WPS

# preprocessing static data: elevation data and geo data
printf "${YELLOW}preprocessing static data (geogrid.exe): ${NC}\n"
./geogrid.exe > ${LOG_PATH}/debug.log

# processing initial data and boundary data
printf "${YELLOW}preprocessing initial and boundary data: ${NC}\n"
./link_grib.csh ${GFS_PATH}/gfs.*.pgrb2.${RESOLUTION}.f*
ln -sf ungrib/Variable_Tables/Vtable.GFS ./Vtable
LD_LIBRARY_PATH=$DIR/grib2/lib ./ungrib.exe >> ${LOG_PATH}/debug.log
./metgrid.exe >> ${LOG_PATH}/debug.log

# starting wrf steps
now=$(date +"%T")
printf "Starting wrf run at ${now}.\n" >> ${LOG_PATH}/log.info

# vertical interpolation preprocessing
printf "${YELLOW}doing vertical interpolation (real.exe): ${NC}\n"
cd ${BUILD_PATH}/WRFV3/test/em_real
ln -sf ../../../WPS/met_em.* .
./real.exe
cp rsl.error.0000 real_error.log

printf "${YELLOW}starting wrf run ... ${NC}\n"
cd ${BUILD_PATH}/WRFV3/test/em_real
mpirun ./wrf.exe

# logging time stamp
now=$(date +"%T")
printf "Finished wrf run at ${now}.\n" >> ${LOG_PATH}/log.info
