#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-11-15 18:08:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-12-31 11:25:52

# main script to deploy a pre compiled version of wrf
# Version 0.6.0
# created by Benjamin Held and other sources, June 2017
# possible parameter:
# --default

# enable termination on error
set -e

# define terminal colors
. ../libs/terminal_color.sh

SCRIPT_PATH=$(pwd)
# default WRFV4 model
export WRF_VERSION_INDEX
# default low resolution WRFV4 geo data
export WRF_GEODATA_INDEX

while [[ $# -gt 0 ]]; do
  case ${1} in
      --default)
      WRF_VERSION_INDEX=1
      WRF_GEODATA_INDEX=4
      shift;;
      -v|--version)
      WRF_VERSION_INDEX="${2}"; shift; shift;;
      -g|--geodata)
      WRF_GEODATA_INDEX="${2}"; shift; shift;;
      --help)
      sh man_help.sh; exit 0;;
      *)
      shift;;
  esac
done

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
