#!/bin/bash

# Script that loads the WRF model specified by argument or 
# selectable index
# the index of the chosen wrf model:
# 1: WRFV4 version 4.4
# 2: WRFV4 version 4.2
# 3: WRFV4 version 4.1.5
# 4: WRFV4 version 4.0.2

# enable termination on error
set -e

# option output
print_options () {
  printf "%b 1: WRFV4 version 4.4\\n%b" "${YELLOW}" "${NC}"
  printf "%b 2: WRFV4 version 4.2\\n%b" "${YELLOW}" "${NC}"
  printf "%b 3: WRFV4 version 4.1.5\\n%b" "${YELLOW}" "${NC}"
  printf "%b 4: WRFV4 version 4.0.2\\n%b" "${YELLOW}" "${NC}"
}

# downloading and unpacking archive
load_wrf_model () {
  ARCHIVE="${DEPLOY_DIR}.tar.gz"
  printf "%b\\nLoading wrf archive: %b\\n" "${YELLOW}" "${NC}"
  wget "${URL_PATH}"
  printf "%b\\nUnpacking archive: %b\\n" "${YELLOW}" "${NC}"
  tar -xzf "${ARCHIVE}"
  rm "${ARCHIVE}"
}

# define terminal colors
. ../../libs/terminal_color.sh

# check for script arguments
if [ -z "${WRF_VERSION_INDEX}" ]; then
  while true; do
    printf "%bSelect the WRF version that should be deployed:\\n%b" "${LIGHT_BLUE}" "${NC}"
    print_options        
    read -r INPUT
    case ${INPUT} in
      [1234]* ) WRF_VERSION_INDEX=${INPUT}; break;;
      * ) printf "%bPlease use a numeric value in [1-4].%b\\n" "${RED}" "${NC}";;
    esac
  done
else
  case ${WRF_VERSION_INDEX} in
    [1234]* ) ;;
    ['--help']* ) printf "%bUsage:\\n%b" "${LIGHT_BLUE}" "${NC}"; print_options;;
    * ) printf "%bError: False argument. Please use a numeric value in [1-4] or --help.%b\\n" "${RED}" "${NC}"; exit 1;;
  esac
fi

case ${WRF_VERSION_INDEX} in
  [1]* ) DEPLOY_DIR='wrf_440'; WRF_FOLDER='WRF-4.4'; WPS_FOLDER='WPS-4.4';;
  [2]* ) DEPLOY_DIR='wrf_420'; WRF_FOLDER='WRF-4.2'; WPS_FOLDER='WPS-4.2';;
  [3]* ) DEPLOY_DIR='wrf_410'; WRF_FOLDER='WRF-4.1.5'; WPS_FOLDER='WPS-4.1';;
  [4]* ) DEPLOY_DIR='wrf_400'; WRF_FOLDER='WRF'; WPS_FOLDER='WPS';;
esac

# creating url for the selectied wrf tar
URL_PATH="https://bheld.eu/data/wrf_deploy/${DEPLOY_DIR}.tar.gz"
SCRIPT_PATH=$(pwd)
cd "${HOME}"

# checking if wrf directory is already there and ask for replacement
if ! [ -d "${HOME}/${DEPLOY_DIR}" ]; then
  load_wrf_model
else
  while true; do
    printf "%b${DEPLOY_DIR} folder already exists, overwrite it? [y/n]\\n%b" "${YELLOW}" "${NC}"        
    read -r INPUT
    case ${INPUT} in
      [y]* ) rm -rf "${HOME:?}/${DEPLOY_DIR}"; load_wrf_model; break;;
      [n]* ) break;;
      * ) printf "%bWrong input Please use [y]es oder [n]o.%b\\n" "${RED}" "${NC}";;
    esac
  done
fi

# copying the config files from the repository to its destination
printf "%b\\nDeploying repository config files: %b\\n" "${YELLOW}" "${NC}"
cd "${SCRIPT_PATH}"
case ${WRF_GEODATA_INDEX} in
    [1]* ) cp ../additions/config/namelist.wps "${HOME}/${DEPLOY_DIR}/${WPS_FOLDER}";;
    [2]* ) cp ../additions/config/namelist_low_res.wps "${HOME}/${DEPLOY_DIR}/${WPS_FOLDER}/namelist.wps";;
esac
cp ../additions/config/namelist.input "${HOME}/${DEPLOY_DIR}/${WRF_FOLDER}/test/em_real/"
cp ../additions/config/tslist "${HOME}/${DEPLOY_DIR}/${WRF_FOLDER}/test/em_real/"

# adjust geo data folder in namelist.wps to default /home/user/geo_data of load_geodata.sh
sed -r -i "s#/home/raziel/geo_data#${HOME}/geo_data#g" "${HOME}/${DEPLOY_DIR}/${WPS_FOLDER}/namelist.wps"

printf "%b\\nFinished wrf deployment.%b\\n" "${YELLOW}" "${NC}"
