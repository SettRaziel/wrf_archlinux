#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-10-23 09:09:29
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-12-14 14:29:01

# Script that loads the WRF model specified by argument or 
# selectable index
# the index of the chosen wrf model:
# 1: WRFV4 version 4.0.2
# 2: WRFV3 version 3.9.1
# 3: WRFV3 version 3.9.0
# 4: WRFV3 version 3.8.1
# 5: WRFV3 version 3.8.0

# option output
print_options () {
  printf "%b 1: WRFV4 version 4.0.2\\n%b" "${YELLOW}" "${NC}"
  printf "%b 2: WRFV3 version 3.9.1\\n%b" "${YELLOW}" "${NC}"
  printf "%b 3: WRFV3 version 3.9.0\\n%b" "${YELLOW}" "${NC}"
  printf "%b 4: WRFV3 version 3.8.1\\n%b" "${YELLOW}" "${NC}"
  printf "%b 5: WRFV3 version 3.8.0\\n%b" "${YELLOW}" "${NC}"
}

# define terminal colors
source ../libs/terminal_color.sh

# check for script arguments
if [ -z "${WRF_VERSION_INDEX}" ]; then
  while true; do
    printf "%bSelect the WRF version that should be deployed:\\n%b" "${LIGHT_BLUE}" "${NC}"
    print_options        
    read INPUT
    case ${INPUT} in
      [12345]* ) WRF_VERSION_INDEX=${INPUT}; break;;
      * ) printf "%bPlease use a numeric value in [1-5].%b\\n" "${RED}" "${NC}";;
    esac
  done
else
  case ${WRF_VERSION_INDEX} in
    [12345]* ) ;;
    ['--help']* ) printf "%bUsage:\\n%b" "${LIGHT_BLUE}" "${NC}"; print_options;;
    * ) printf "%bError: False argument. Please use a numeric value in [1-5] or --help.%b\\n" "${RED}" "${NC}"; exit 1;;
  esac
fi

case ${WRF_VERSION_INDEX} in
  [1]* ) FILE_NAME='wrf_400'; WRF_FOLDER='WRF';;
  [2]* ) FILE_NAME='wrf_391'; WRF_FOLDER='WRFV3';;
  [3]* ) FILE_NAME='wrf_390'; WRF_FOLDER='WRFV3';;
  [4]* ) FILE_NAME='wrf_381'; WRF_FOLDER='WRFV3';;
  [5]* ) FILE_NAME='wrf_380'; WRF_FOLDER='WRFV3';;
esac

# creating url for the selectied wrf tar
URL_PATH="https://bheld.eu/data/wrf_deploy/${FILE_NAME}.tar.gz"
SCRIPT_PATH=$(pwd)
cd ${HOME} || exit 1

# downloading and unpacking archive
printf "%b\\nLoading wrf archive: %b\\n" "${YELLOW}" "${NC}"
wget ${URL_PATH}
printf "%b\\nUnpacking archive: %b\\n" "${YELLOW}" "${NC}"
tar -xzf ${FILE_NAME}.tar.gz
rm ${FILE_NAME}.tar.gz

# copying the config files from the repository to its destination
printf "%b\\nDeploying repository config files: %b\\n" "${YELLOW}" "${NC}"
cd "${SCRIPT_PATH}" || exit 1
case ${WRF_GEODATA_INDEX} in
    [4]* ) cp ../additions/config/namelist_low_res.wps "${HOME}/${FILE_NAME}/WPS/namelist.wps";;
    * ) cp ../additions/config/namelist.wps "${HOME}/${FILE_NAME}/WPS";;
esac
cp ../additions/config/namelist.input "${HOME}/${FILE_NAME}/${WRF_FOLDER}/test/em_real/"
cp ../additions/config/tslist "${HOME}/${FILE_NAME}/${WRF_FOLDER}/test/em_real/"

printf "%b\\nFinished wrf deployment.%b\\n" "${YELLOW}" "${NC}"
