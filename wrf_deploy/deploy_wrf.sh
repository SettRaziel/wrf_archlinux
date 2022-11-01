#!/bin/bash

# main script to deploy a pre compiled version of wrf
# Version 0.8.1
# created by Benjamin Held and other sources, June 2017
# possible parameter:
# --default

# enable termination on error
set -e

# define terminal colors
. ../libs/terminal_color.sh

SCRIPT_PATH=$(pwd)
source "./linux/set_env.sh"

while [[ $# -gt 0 ]]; do
  case ${1} in
      --default)
      WRF_VERSION_INDEX=1
      WRF_GEODATA_INDEX=2
      shift;;
      -v|--version)
      WRF_VERSION_INDEX="${2}"; shift; shift;;
      -g|--geodata)
      WRF_GEODATA_INDEX="${2}"; shift; shift;;
      --help)
      cd "${SCRIPT_PATH}/help"
      sh "./help/man_help.sh"; exit 0;;
      *)
      shift;;
  esac
done

# check and load required packages
cd "${SCRIPT_PATH}/linux"
sh ./load_packages.sh
cd "${SCRIPT_PATH}"

# create storage folder for the gfs input data
if ! [ -d "${HOME}/gfs_data" ]; then
  mkdir "${HOME}/gfs_data"
fi

# load and unpack the neccessary geodata, WRFV4 minimal
# using source to get the environment variable for WRF_GEODATA_INDEX
cd "${SCRIPT_PATH}/wrf"
source ./load_geodata.sh
cd "${SCRIPT_PATH}"

# setting up output visualization
cd "${SCRIPT_PATH}/visualization"
sh ./load_visualization.sh
cd "${SCRIPT_PATH}"

# load and unpack the wrf archive, default version 4.4.0
cd "${SCRIPT_PATH}/wrf"
sh ./load_wrf.sh
cd "${SCRIPT_PATH}"

cd "${SCRIPT_PATH}/post_processing"
# check if directories exists
sh ./check_deployment.sh "${DEPLOY_DIR}"
# clean up packages
sh ./clean_up.sh
