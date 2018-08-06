#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   benjamin
# @Last Modified time: 2018-08-01 17:45:26

# Script to run the preprocessing operations
# $1: the path to the wrf root folder

# define terminal colors
source ../terminal_color.sh
source ../set_env.sh

# cleaning up in wps preprocessing folder
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Cleaning up output data from last time at ${now}\n" >> ${LOG_PATH}/log.info

# remove previous output files
rm ${HOME}/wrf_output/wrfout_*
rm ${HOME}/wrf_output/Han.*
rm ${HOME}/wrf_output/Ith.*
