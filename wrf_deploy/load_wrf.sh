#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-10-23 09:09:29
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-07-21 08:56:07

# help output
function print_options () {
  printf "${YELLOW} 1: WRFV4 version 4.0.2\n${NC}"
  printf "${YELLOW} 2: WRFV3 version 3.9.1\n${NC}"
  printf "${YELLOW} 3: WRFV3 version 3.9.0\n${NC}"
  printf "${YELLOW} 4: WRFV3 version 3.8.1\n${NC}"
  printf "${YELLOW} 5: WRFV3 version 3.8.0\n${NC}"
}

# define terminal colors
source ../libs/terminal_color.sh

# Default selection
SELECT_VALUE=2
# Default wrf directory corresponding to v3.9.1
WRF_FOLDER='WRFV3'

# check for script arguments
if [ $# -ne 1 ] 
then
  while true; do
    printf "${LIGHT_BLUE}Select the WRF version that should be deployed:\n${NC}"
    print_options        
    read INPUT
    case ${INPUT} in
      [12345]* ) SELECT_VALUE=${INPUT}; break;;
      * ) printf "${RED}Please use a numeric value in [1-5].${NC}\n";;
    esac
  done
else
  case ${1} in
    [12345]* ) SELECT_VALUE=${1};;
    ['--help']* ) printf "${LIGHT_BLUE}Usage:\n${NC}"; print_options;;
    * ) printf "${RED}Error: False argument. Please use a numeric value in [1-5] or --help.${NC}\n";;
  esac
fi

case ${SELECT_VALUE} in
  [1]* ) FILE_NAME='wrf_400'; WRF_FOLDER='WRF';;
  [2]* ) FILE_NAME='wrf_391';;
  [3]* ) FILE_NAME='wrf_390';;
  [4]* ) FILE_NAME='wrf_381';;
  [5]* ) FILE_NAME='wrf_380';;
esac

# creating url for the selectied wrf tar
URL_PATH="https://bheld.eu/data/wrf_deploy/${FILE_NAME}.tar.gz"
SCRIPT_PATH=$(pwd)
cd ${HOME}

# downloading and unpacking archive
printf "${YELLOW}\nLoading wrf archive: ${NC}\n"
wget ${URL_PATH}
printf "${YELLOW}\nUnpacking archive: ${NC}\n"
tar -xzf ${FILE_NAME}.tar.gz
rm ${FILE_NAME}.tar.gz

# copying the config files from the repository to its destination
printf "${YELLOW}\nDeploying repository config files: ${NC}\n"
cd ${SCRIPT_PATH}
cp ../additions/config/namelist.wps ${HOME}/${FILE_NAME}/WPS
cp ../additions/config/namelist.input ${HOME}/${FILE_NAME}/${WRF_FOLDER}/test/em_real/
cp ../additions/config/tslist ${HOME}/${FILE_NAME}/${WRF_FOLDER}/test/em_real/

printf "${YELLOW}\nFinished wrf deployment.${NC}\n"
