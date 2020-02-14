#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 16:04:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-13 21:19:56

# script to generate output pictures from a model run
# ${1}: the year for the model run
# ${2}: the month for the model run
# ${3}: the day for the model run
# ${4}: the hour of the model run
# ${5}: the timespan for the model run

# setting -e to abort on error
set -e

# define terminal colors
source ${COLOR_PATH}

# error handling for input parameter
if [ "$#" -ne 5 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR> <PERIOD>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting output generation at %s.\\n" "${now}" >> "${INFO_LOG}"

YEAR=${1}
MONTH=${2}
DAY=${3}
HOUR=${4}
PERIOD=${5}
# optional addition to the storage path
DEST_SUFFIX='_test'
DEST_FOLDER="${SCRIPT_PATH}/${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}"

# ncl requires libgfortran3.so, so adding it to the library path for usage here
export LD_LIBRARY_PATH="/usr/lib/gcc/x86_64-pc-linux-gnu/6.5.0/:${LD_LIBRARY_PATH}"

# create parent folder for time stamp
mkdir "${DEST_FOLDER}"

# generate all listed meteograms
cd "${SCRIPT_PATH}" || exit 1
sh ./draw_meteograms.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}" "${DEST_FOLDER}"

cd "${HOME}/wrf_output" || exit 1

# generate output
ncl plot_timestamp_output >> "${DEBUG_LOG}"
ncl plot_tot_rain >> "${DEBUG_LOG}"

find . -maxdepth 1 -name '*.png' -exec optipng {} \;

# create folder and move output
mkdir "${DEST_FOLDER}/comp"
mkdir "${DEST_FOLDER}/rain_3h"
mkdir "${DEST_FOLDER}/rain_tot"
mkdir "${DEST_FOLDER}/thunderstorm_index"

# Check for moveable file and move them if present
[ ! -f comp_*.png ] || mv comp_*.png "${DEST_FOLDER}/comp"
[ ! -f rain_3h_*.png ] || mv rain_3h_*.png "${DEST_FOLDER}/rain_3h"
[ ! -f rain_tot_*.png ] || mv rain_tot_*.png "${DEST_FOLDER}/rain_tot"
[ ! -f thunderstorm_*.png ] || mv thunderstorm_*.png "${DEST_FOLDER}/thunderstorm_index"

# generate meat.ini file
cd "${SCRIPT_PATH}" || exit 1
sh create_ini.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}" "${DEST_FOLDER}"

# logging time stamp
now=$(date +"%T")
printf "Finished output generation at %s.\\n" "${now}" >> "${INFO_LOG}"
