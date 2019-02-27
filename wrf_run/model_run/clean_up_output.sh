#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-02-27 10:59:56

# Script to run the preprocessing operations
# $1: the path to the wrf root folder

source ../set_env.sh

# cleaning up in wps preprocessing folder
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Cleaning up output data from last time at ${now}\n" >> ${LOG_PATH}/log.info

# remove previous output files
rm ${HOME}/wrf_output/wrfout_*
rm ${HOME}/wrf_output/Han.*
rm ${HOME}/wrf_output/Ith.*
