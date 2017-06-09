#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-06-09 17:19:39

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script to run the preprocessing operations
# $1: the path to the wrf root folder

source ../set_env.sh

# cleaning up in wps preprocessing folder
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Cleaning up output data from last time at ${now}\n" >> ${SCRIPT_PATH}/../log.info

# remove previous output files
rm ${HOME}/wrf_output/wrfout_*
rm ${HOME}/wrf_output/Han.*
rm ${HOME}/wrf_output/Ith.*
