#!/bin/bash

# script to generate output meteograms from a model run
# ${1}: the year for the model run
# ${2}: the month for the model run
# ${3}: the day for the model run
# ${4}: the hour of the model run
# ${5}: the folder where the the visualizations scripts are stored
# ${6}: the destination folder of the output

# setting -e to abort on error
set -e

# function to move the files of a given pattern to the destination
move_files () {
  FILE_PATTERN=${1}
  MOVE_FOLDER=${2}

  for FILE_NAME in ${FILE_PATTERN}; do
    if [ -e "${FILE_NAME}" ]; then
      mv "${FILE_NAME}" "${MOVE_FOLDER}"
    else
      printf "No meteogram file for pattern %s.\\n" "${FILE_PATTERN}" >> "${DEBUG_LOG}"      
    fi
  done
}

# define terminal colors
. "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 5 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR> <WRF_VIZ>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# logging time stamp
printf "Starting meteograms at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"

START_DATE="${1}-${2}-${3} ${4}:00"
# path for external python visualization tool
WRF_VISUALIZATION="${5}"

cd "${WRF_VISUALIZATION}/lib/meteogram" || exit 1
# move required meteogram files to output folder
printf "Moving data for meteograms at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
move_files "${WRF_DIR}/test/em_real/*.PH" "${WRF_OUTPUT}"
move_files "${WRF_DIR}/test/em_real/*.PR" "${WRF_OUTPUT}"
move_files "${WRF_DIR}/test/em_real/*.QV" "${WRF_OUTPUT}"
move_files "${WRF_DIR}/test/em_real/*.TH" "${WRF_OUTPUT}"
move_files "${WRF_DIR}/test/em_real/*.TS" "${WRF_OUTPUT}"
move_files "${WRF_DIR}/test/em_real/*.UU" "${WRF_OUTPUT}"
move_files "${WRF_DIR}/test/em_real/*.VV" "${WRF_OUTPUT}"
move_files "${WRF_DIR}/test/em_real/*.WW" "${WRF_OUTPUT}"

# source conda to use in subshell (https://github.com/conda/conda/issues/7980)
. /opt/miniconda3/etc/profile.d/conda.sh
# call python script for meteogram creation
printf "Calling python code for meteograms at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
printf "%b\\nCreating meteogram output: %b\\n" "${YELLOW}" "${NC}" >> "${DEBUG_LOG}"
conda activate wrf_env
python plot_meteograms.py "${START_DATE}" >> "${DEBUG_LOG}"
conda deactivate

# optimize png size
find . -maxdepth 1 -name '*.png' -exec optipng {} \;

# logging time stamp
printf "Finished meteograms at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
