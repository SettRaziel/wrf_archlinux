#!/bin/bash

# Script that loads the WPS geodata specified by argument or 
# selectable index
# the index of the chosen geo data:
# 1: WRFV4 high resolution data
# 2: WRFV4 low resolution data

print_options () {
  printf "%b 1: WRFV4 high resolution data\\n%b" "${YELLOW}" "${NC}"
  printf "%b 2: WRFV4 low resolution data\\n%b" "${YELLOW}" "${NC}"
}

# define terminal colors
. ../libs/terminal_color.sh

# check for script arguments
if [ -z "${WRF_GEODATA_INDEX}" ]; then
  while true; do
    printf "%bSelect geographical data for WPS preprocessing:\\n%b" "${LIGHT_BLUE}" "${NC}"
    print_options        
    read -r INPUT
    case ${INPUT} in
      [12]* ) WRF_GEODATA_INDEX=${INPUT}; break;;
      * ) printf "%bPlease use a numeric value in [1-2].%b\\n" "${RED}" "${NC}";;
  	esac
  done
else
  case ${WRF_GEODATA_INDEX} in
    [1234]* ) ;;
    ['--help']* ) printf "%bUsage:\\n%b" "${LIGHT_BLUE}" "${NC}"; print_options;;
    * ) printf "%bError: False argument. Please use a numeric value in [1-2] or --help.%b\\n" "${RED}" "${NC}"; exit 1;;
  esac
fi

# select the geodata
case ${WRF_GEODATA_INDEX} in
  [1]* ) FILE_NAME='geog_high_res_mandatory.tar.gz';;
  [2]* ) FILE_NAME='geog_low_res_mandatory.tar.gz';;
esac

# load and deploy the geodata
URL_PATH="http://www2.mmm.ucar.edu/wrf/src/wps_files/${FILE_NAME}"

# checking if geodata directory is already there and ask for replacement
if ! [ -d "${HOME}/geo_data" ]; then
  mkdir "${HOME}/geo_data"
else
  while true; do
    printf "%bGeodata folder already exists, replace it? [y/n]\\n%b" "${YELLOW}" "${NC}"        
    read -r INPUT
    case ${INPUT} in
      [y]* ) rm -rf "${HOME}/geo_data"; mkdir "${HOME}/geo_data"; break;;
      [n]* ) break;;
      * ) printf "%bWrong input Please use [y]es oder [n]o.%b\\n" "${RED}" "${NC}";;
    esac
  done
fi

cd "${HOME}/geo_data" || exit 1

printf "%b\\nLoading data files: %b\\n" "${YELLOW}" "${NC}"
wget "${URL_PATH}"
printf "%b\\nUnpacking archive: %b\\n" "${YELLOW}" "${NC}"
tar -xzf ${FILE_NAME}
rm ${FILE_NAME}
printf "%b\\nFinished loading geodata.%b\\n" "${YELLOW}" "${NC}"
