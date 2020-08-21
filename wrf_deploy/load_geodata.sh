#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-04 11:57:18
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-21 23:13:18

# Script that loads the WPS geodata specified by argument or 
# selectable index
# the index of the chosen geo data:
# 1: WRFV3 high resolution data
# 2: WRFV3 low resolution data
# 3: WRFV4 high resolution data
# 4: WRFV4 low resolution data

print_options () {
  printf "%b 1: WRFV3 high resolution data\\n%b" "${YELLOW}" "${NC}"
  printf "%b 2: WRFV3 low resolution data\\n%b" "${YELLOW}" "${NC}"
  printf "%b 3: WRFV4 high resolution data\\n%b" "${YELLOW}" "${NC}"
  printf "%b 4: WRFV4 low resolution data\\n%b" "${YELLOW}" "${NC}"
}

# define terminal colors
. ../libs/terminal_color.sh

# check for script arguments
if [ -z "${WRF_GEODATA_INDEX}" ]; then
  while true; do
    printf "%bSelect geographical data for WPS preprocessing:\\n%b" "${LIGHT_BLUE}" "${NC}"
    print_options        
    read INPUT
    case ${INPUT} in
      [1234]* ) WRF_GEODATA_INDEX=${INPUT}; break;;
      * ) printf "%bPlease use a numeric value in [1-4].%b\\n" "${RED}" "${NC}";;
  	esac
  done
else
  case ${WRF_GEODATA_INDEX} in
    [1234]* ) ;;
    ['--help']* ) printf "%bUsage:\\n%b" "${LIGHT_BLUE}" "${NC}"; print_options;;
    * ) printf "%bError: False argument. Please use a numeric value in [1-4] or --help.%b\\n" "${RED}" "${NC}"; exit 1;;
  esac
fi

# select the geodata
case ${WRF_GEODATA_INDEX} in
  [1]* ) FILE_NAME='geog_complete.tar.gz';;
  [2]* ) FILE_NAME='geog_minimum.tar.bz2';;
  [3]* ) FILE_NAME='geog_high_res_mandatory.tar.gz';;
  [4]* ) FILE_NAME='geog_low_res_mandatory.tar.gz';;
esac

# load and deploy the geodata
URL_PATH="http://www2.mmm.ucar.edu/wrf/src/wps_files/${FILE_NAME}"

if [ -d "${HOME}/geo_data" ]; then
  while true; do
    printf "%bGeodata folder already exists, replace it? [y/n]\\n%b" "${LIGHT_BLUE}" "${NC}"        
    read INPUT
    case ${INPUT} in
      [y]* ) rm -rf "${HOME}/geo_data"; mkdir "${HOME}/geo_data"; break;;
      [n]* ) ;;
      * ) printf "%bWrong input Please use [y]es oder [n]o.%b\\n" "${RED}" "${NC}";;
    esac
  done
fi

cd "${HOME}/geo_data" || exit 1

printf "%b\\nLoading data files: %b\\n" "${YELLOW}" "${NC}"
wget ${URL_PATH}
printf "%b\\nUnpacking archive: %b\\n" "${YELLOW}" "${NC}"
if [ ${WRF_GEODATA_INDEX} -eq 2 ]
then
  tar -xjf ${FILE_NAME}
else
  tar -xzf ${FILE_NAME}
fi
rm ${FILE_NAME}
printf "%b\\nFinished loading geodata.%b\\n" "${YELLOW}" "${NC}"
