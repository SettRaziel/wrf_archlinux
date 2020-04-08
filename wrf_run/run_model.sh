#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-05 15:05:06

# main script for starting a wrf model run
# Version 0.4.4
# created by Benjamin Held and other sources, June 2017
# Two possible parameter sets:
# <START_HOUR> <PERIOD> <RESOLUTION> <PERIOD>
# <START_YEAR> <START_MONTH> <START_DAY> <START_HOUR> <PERIOD> <RESOLUTION>

error_exit () {
  NOW=$(date +"%T")
  ERROR_STATUS="${1} at: ${NOW}."
  printf "%s\\n" "${ERROR_STATUS}" >> "${ERROR_LOG}"
  printf "Error: %s at: %s.\\n" "${1}" "${NOW}" >> "${STATUS_LOG}"
  cd "${SCRIPT_PATH}" || exit 1
  sh create_mail.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${ERROR_STATUS}" "Fail"
  echo "${1}" 1>&2
  exit 1
}

# required variables
SCRIPT_PATH=$(pwd)
BUILD_PATH="<wrf path>"
source "${SCRIPT_PATH}/set_env.sh" "${BUILD_PATH}" "${SCRIPT_PATH}"
# default variables
GFS_PATH=${HOME}/gfs_data

if [ "$#" -eq 3 ]; then # no argument, run whole script
  YEAR=$(date '+%Y')
  MONTH=$(date '+%m')
  DAY=$(date '+%d')
  HOUR=${1}
  PERIOD=${2}
  RESOLUTION=${3}
elif [ "$#" -eq 6 ]; then
  YEAR=${1}
  MONTH=${2}
  DAY=${3}
  HOUR=${4}
  PERIOD=${5}
  RESOLUTION=${6}
else
  echo "Wrong number of arguments."
  echo "Must either be three for <HOUR> <PERIOD> <RESOLUTION>"
  echo "or six for <YEAR> <MONTH> <DAY> <HOUR> <PERIOD> <RESOLUTION>"
  exit 1
fi

LCK="./lock.file";
exec 42>${LCK};

flock -x 42;
# preparing status file
printf "Starting new model run for: %s/%s/%s %s:00 UTC.\\n" "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" > "${STATUS_LOG}"

# adjusting namelist for next run
cd "${SCRIPT_PATH}/model_run" || error_exit "Failed cd namelist"
printf "Starting namelist preparation.\\n" >> "${STATUS_LOG}"
sh prepare_namelist.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}"; RET=${?}
if ! [ ${RET} -eq 0 ]; then
  error_exit "Failed to prepare the namelist files"
fi

# fetching input data
cd "${SCRIPT_PATH}/data_fetch" || error_exit "Failed cd data_fetch"
printf "Starting namelist preparation.\\n" >> "${STATUS_LOG}"
sh gfs_fetch.sh "${YEAR}${MONTH}${DAY}" "${HOUR}" "${GFS_PATH}" "${RESOLUTION}" "${PERIOD}"; RET=${?}
if ! [ ${RET} -eq 0 ]; then
  error_exit "Failed to prepare the namelist files"
fi

# start model run
cd "${SCRIPT_PATH}/model_run" || error_exit "Failed cd start model_run"
printf "Starting model run and preparation.\\n" >> "${STATUS_LOG}"
sh run_preprocessing.sh "${GFS_PATH}" "${RESOLUTION}"; RET=${?}
cd "${SCRIPT_PATH}" || error_exit "Failed cd to script path"
if ! [ ${RET} -eq 0 ]; then
    cd "${WRF_DIR}/test/em_real/" || error_exit "Failed cd to WRF folder"
    rm wrfout_d01_*
    error_exit "Failed to run the model"
fi

# move output files
cd "${SCRIPT_PATH}/model_run" || error_exit "Failed cd to model_run"
sh clean_up_output.sh; RET=${?}
if [ ${RET} -eq 0 ]; then
  mv "${WRF_DIR}"/test/em_real/wrfout_d01_* "${HOME}/wrf_output"
else
    error_exit "Error while cleaning up previous output files"
fi

# run output script
cd "${SCRIPT_PATH}/post_processing" || error_exit "Failed cd postprocessing"
printf "Starting postprocessing.\\n" >> "${STATUS_LOG}"
sh draw_plots.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}"; RET=${?}
if [ ${RET} -eq 0 ]; then
  printf "Starting archive generation.\\n" >> "${STATUS_LOG}"
  cd "${HOME}/wrf_output" || error_exit "Failed cd to model_output"
  #tar czf wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz wrfout_d01_* Han.d01.* Ith.d01.*
  #mv wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz history/
else
    error_exit "Error while creating output files"
fi

# finish up model run and send notification mail
cd "${SCRIPT_PATH}" || error_exit "Failed cd finish mail"
sh create_mail.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "Finished model run without error." "Success"
printf "Finished model run without error.\\n" >> "${STATUS_LOG}"
