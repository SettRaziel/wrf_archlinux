#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-04-30 17:36:09
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-04-30 17:38:37

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to run the preprocessing operations
# $1: the path to the wrf root folder

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting wrf run at ${now}.\n" >> $SCRIPT_PATH/log.info
cd $1/WRFV3/test/em_real

mpirun ./wrf.exe

# logging time stamp
now=$(date +"%T")
printf "Finished wrf run at ${now}.\n" >> $SCRIPT_PATH/log.info
