#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-17 21:11:08

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to run the preprocessing operations
# $1: the path to the wrf root folder

# cleaning up in wps preprocessing folder
printf "${YELLOW}Cleaning up wps data from last time: ${NC}\n"
cd $1/WPS

# remove met_em files from the last run
rm met_em.d01.*

# remove grib files
rm GRIB*

# remove FILE objects of the time stamps
rm FILE:*

# cleaning up in wrf
printf "${YELLOW}Cleaning up wrf data from last time: ${NC}\n"
cd $1/WRFV3/test/em_real/

# remove met_em files from the last run
rm met_em.d01.*
printf "${YELLOW}Finished clean up.${NC}\n"
