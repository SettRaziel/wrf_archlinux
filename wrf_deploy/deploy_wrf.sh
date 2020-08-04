#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-11-15 18:08:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-04 16:44:38

# main script to deploy a pre compiled version of wrf
# Version 0.4.6
# created by Benjamin Held and other sources, June 2017
# possible parameter:
# --default

# enable termination on error
set -e

SCRIPT_PATH=$(pwd)
# set environment variables
if [ "${1}" = '--default' ]; then
	# default: 1 for WRFV4 and 4 for WRFV4 low res geodata
	source ./set_env.sh 1 4
else
	# no values for environment variables, so manual setting
	source ./set_env.sh
fi

# check and load required packages
sh ./load_packages.sh

# create storage folder for the gfs input data
if ! [ -d "${HOME}/gfs_data" ]; then
  mkdir "${HOME}/gfs_data"
fi

# load and unpack the neccessary geodata, WRFV4 minimal
# using source to get the environment variable for WRF_GEODATA_INDEX
source ./load_geodata.sh
cd "${SCRIPT_PATH}" || exit 1

# setting up output visualization
sh ./load_visualization.sh
cd "${SCRIPT_PATH}" || exit 1

# load and unpack the wrf archive, default version 4.2.0
sh ./load_wrf.sh
