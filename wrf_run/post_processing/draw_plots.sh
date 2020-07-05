#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 16:04:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-07-05 11:11:35

# script to generate output pictures from a model run
# ${1}: the year for the model run
# ${2}: the month for the model run
# ${3}: the day for the model run
# ${4}: the hour of the model run
# ${5}: the timespan for the model run

# setting -e to abort on error
set -e

# function to move the files of a given pattern to the destination
move_files () {
	FILE_PATTERN=${1}
	MOVE_FOLDER=${2}

	for FILE_NAME in ${FILE_PATTERN}; do
    if [ -e "${FILE_NAME}" ]; then
      mv "${FILE_NAME}" "${MOVE_FOLDER}"
	  fi
  done
}

# function to check if the destination already exists, if not create it
create_directory () {
  DESTINATION=${1}
  if ! [ -d "${DESTINATION}" ]; then
    mkdir "${DESTINATION}"
  fi
}

# define terminal colors
. "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 5 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR> <PERIOD>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# logging time stamp
SCRIPT_PATH=$(pwd)
printf "Starting output generation at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"

YEAR=${1}
MONTH=${2}
DAY=${3}
HOUR=${4}
PERIOD=${5}

# optional addition to the storage path
DEST_SUFFIX='_test'
DEST_FOLDER="${SCRIPT_PATH}/${MONTH}_${DAY}_${HOUR}${DEST_SUFFIX}"

# create parent folder for time stamp
create_directory "${DEST_FOLDER}"

# generate all listed meteograms
cd "${SCRIPT_PATH}" || exit 1 
sh ./draw_meteograms.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${WRF_VISUALIZATION}" "${DEST_FOLDER}"

cd "${WRF_VISUALIZATION}/lib/composite" || exit 1

# source conda to use in subshell (https://github.com/conda/conda/issues/7980)
. /opt/miniconda3/etc/profile.d/conda.sh
# generate output
conda activate wrf_env
python plot_composites.py >> "${DEBUG_LOG}"
conda deactivate

# optimizing output file quality
find . -maxdepth 1 -name '*.png' -exec optipng {} \;

# create folder and move output
create_directory "${DEST_FOLDER}/comp"
create_directory "${DEST_FOLDER}/rain_3h"
create_directory "${DEST_FOLDER}/rain_tot"
create_directory "${DEST_FOLDER}/thunderstorm_index"

# Check for moveable file and move them if present
cd "${WRF_OUTPUT}"
move_files "comp_*.png" "${DEST_FOLDER}/comp"
move_files "rain_3h_*.png" "${DEST_FOLDER}/rain_3h"
move_files "rain_total_*.png" "${DEST_FOLDER}/rain_tot"
move_files "cape_*.png" "${DEST_FOLDER}/thunderstorm_index"

# generate meta.ini file
printf "Starting generation of meta.ini at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
cd "${SCRIPT_PATH}" || exit 1
sh create_ini.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}" "${DEST_FOLDER}"

# logging time stamp
printf "Finished output generation at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
