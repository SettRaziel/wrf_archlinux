#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-03-14 17:38:02

# main script for starting a wrf model run
# Version 0.6.0
# created by Benjamin Held and other sources, June 2017

error_exit () {
  cd "${SCRIPT_PATH}/notification" || exit 1
  sh handle_error.sh "${1}" "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}"
  exit 1
}

# required variables
SCRIPT_PATH=$(pwd)
export COLOR_PATH="${SCRIPT_PATH}/../libs/terminal_color.sh"

# default parameters
BUILD_PATH="<wrf path>"
GFS_PATH=${HOME}/gfs_data
YEAR=$(date '+%Y')
MONTH=$(date '+%m')
DAY=$(date '+%d')  

while [[ $# -gt 0 ]]; do
  case ${1} in
      -b|--build)
      BUILD_PATH="${2}"; shift; shift;;
      -y|--year)
      YEAR="${2}"; shift; shift;;
      -m|--month)
      MONTH="${2}"; shift; shift;;
      -d|--day)
      DAY="${2}"; shift; shift;;
      -h|--hour)
      HOUR="${2}"; shift; shift;;
      -p|--period)
      PERIOD="${2}"; shift; shift;;
      -r|--resolution)
      RESOLUTION="${2}"; shift; shift;;
      --help)
      sh help/man_help.sh; exit 0;;
      *)
      shift;;
  esac
done

source "${SCRIPT_PATH}/set_env.sh" "${BUILD_PATH}" "${SCRIPT_PATH}"

# preparing status file
printf "Starting new model run for: %s/%s/%s %s:00 UTC at %s.\\n" "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "$(date +"%T")" > "${STATUS_LOG}"
printf "Starting new model run for: %s/%s/%s %s:00 UTC at %s.\\n" "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "$(date +"%T")" > "${INFO_LOG}"

cd "${SCRIPT_PATH}/validate" || error_exit "Failed cd parameter validation"
sh validate_parameter.sh "${BUILD_PATH}" "${PERIOD}" "${RESOLUTION}"; RET=${?}
if ! [ ${RET} -eq 0 ]; then
  error_exit "Input parameter are invalid, check script call"
fi

# Check and lock control file
LCK="${SCRIPT_PATH}/lock.file";
exec 42>"${LCK}";
flock -x 42;

# adjusting namelist for next run
cd "${SCRIPT_PATH}/model_run" || error_exit "Failed cd namelist"
printf "Starting namelist preparation at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
sh prepare_namelist.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}"; RET=${?}
if ! [ ${RET} -eq 0 ]; then
  error_exit "Failed to prepare the namelist files"
fi

# fetching input data
cd "${SCRIPT_PATH}/data_fetch" || error_exit "Failed cd data_fetch"
printf "Starting data fetching at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
sh gfs_fetch.sh "${YEAR}${MONTH}${DAY}" "${HOUR}" "${GFS_PATH}" "${RESOLUTION}" "${PERIOD}"; RET=${?}
if ! [ ${RET} -eq 0 ]; then
  error_exit "Failed to prepare the namelist files"
fi

# start model run
cd "${SCRIPT_PATH}/model_run" || error_exit "Failed cd start model_run"
printf "Starting model run preparation at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
sh run_preprocessing.sh; RET=${?}
if ! [ ${RET} -eq 0 ]; then
  error_exit "Failed preparations for the model run"
fi

cd "${SCRIPT_PATH}/model_run" || error_exit "Failed cd start model_run"
printf "Starting model run at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
sh run_wrfmodel.sh "${GFS_PATH}" "${RESOLUTION}"; RET=${?}
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
  mv "${WRF_DIR}"/test/em_real/wrfout_d01_* "${WRF_OUTPUT}"
else
  error_exit "Error while cleaning up previous output files"
fi

# run output script
cd "${SCRIPT_PATH}/post_processing" || error_exit "Failed cd postprocessing"
printf "Starting postprocessing at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
sh draw_plots.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}"; RET=${?}
if [ ${RET} -eq 0 ]; then
  printf "Starting archive generation at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
  cd "${WRF_OUTPUT}" || error_exit "Failed cd to model_output"
  #tar czf wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz wrfout_d01_* Han.d01.* Ith.d01.*
  #mv wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz history/
else
  error_exit "Error while creating output files"
fi

# run post hook scripts
cd "${SCRIPT_PATH}/post_processing" || error_exit "Failed cd postprocessing"
printf "Starting post hook activities at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
sh post_hook.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${PERIOD}" "${RESOLUTION}"; RET=${?}
if [ ${RET} -ne 0 ]; then
  error_exit "Error executing post hook activities"  
fi

# finish up model run and send notification mail
cd "${SCRIPT_PATH}/notification" || error_exit "Failed cd finish mail"
SUCCESS_MESSAGE="Finished model run without error"
sh create_mail.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${SUCCESS_MESSAGE}." "Success"
printf "${SUCCESS_MESSAGE} at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
