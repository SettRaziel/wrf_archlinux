#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-07 19:02:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-04-08 22:00:54

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to run the preprocessing operations
# $1: the path to the wrf root folder
# $2: the path to the geodata

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting preprocessing at ${now}.\n" >> $SCRIPT_PATH/log.info

# opening wps folder
cd $1/WPS

# preprocessing static data: elevation data and geo data
printf "${YELLOW}preprocessing static data (geogrid.exe): ${NC}\n"
./geogrid.exe > $SCRIPT_PATH/debug.log

# processing initial data and boundary data
printf "${YELLOW}preprocessing initial and boundary data: ${NC}\n"
./link_grib.csh $2/gfs.*.pgrb2.0p50.f*
ln -sf ungrib/Variable_Tables/Vtable.GFS ./Vtable
LD_LIBRARY_PATH=$DIR/grib2/lib ./ungrib.exe >> $SCRIPT_PATH/debug.log
./metgrid.exe >> $SCRIPT_PATH/debug.log

# vertical interpolation preprocessing
printf "${YELLOW}doing vertical interpolation (real.exe): ${NC}\n"
cd $1/WRFV3/test/em_real
ln -sf ../../../WPS/met_em.* .
./real.exe
cp rsl.error.0000 real_error.log

# logging time stamp
now=$(date +"%T")
printf "Starting wrf run at ${now}.\n" >> $SCRIPT_PATH/log.info

printf "${YELLOW}starting wrf run ... ${NC}\n"
mpirun ./wrf.exe

# logging time stamp
now=$(date +"%T")
printf "Finished wrf run at ${now}.\n" >> $SCRIPT_PATH/log.info
