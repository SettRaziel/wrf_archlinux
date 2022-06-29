#!/bin/bash

# script to check if the deployment directories are present

# enable termination on error
set -e

DEPLOY_DIR="${1}"

# define terminal colors
. ../libs/terminal_color.sh

# checking if geodata directory is present
printf "%bChecking for geodata folder...\\n%b" "${YELLOW}" "${NC}"        
if ! [ -d "${HOME}/geo_data" ]; then
  printf "%bDirectory for geodata cannot be found.%b\\n" "${RED}" "${NC}";
  exit 1
fi

# checking if gfs data directory is present
printf "%bChecking for gfs input data folder...\\n%b" "${YELLOW}" "${NC}"        
if ! [ -d "${HOME}/gfs_data" ]; then
  printf "%bDirectory for gfs input data cannot be found.%b\\n" "${RED}" "${NC}";
  exit 1
fi

# checking if wrf directory is present
printf "%bChecking for wrf data folder...\\n%b" "${YELLOW}" "${NC}"        
if ! [ -d "${HOME}/${DEPLOY_DIR}" ]; then
  printf "%bDirectory for wrf data cannot be found.%b\\n" "${RED}" "${NC}";
  exit 1
fi

# checking if visualization is present
printf "%bChecking for visualization folder...\\n%b" "${YELLOW}" "${NC}"        
if ! [ -d "${HOME}/wrf_visualization" ]; then
  printf "%bDirectory for visualization cannot be found.%b\\n" "${RED}" "${NC}";
  exit 1
fi
