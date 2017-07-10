#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 16:04:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-07-10 20:45:09

source ${HOME}/scripts/set_env.sh

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting postprocessing at ${now}.\n" >> ${SCRIPT_PATH}/log.info

# generate output

# logging time stamp
now=$(date +"%T")
printf "Finished postprocessing at ${now}.\n" >> ${SCRIPT_PATH}/log.info
