#!/bin/bash

# script to archive output pictures from a model run when required parameter is set
# ${1}: the year for the model run
# ${2}: the month for the model run
# ${3}: the day for the model run
# ${4}: the hour of the model run

# setting -e to abort on error
set -e

# define terminal colors
. "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 4 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

printf "Starting archive generation at %s.\\n" "$(date +"%T")" >> "${STATUS_LOG}"
cd "${WRF_OUTPUT}" || error 1
if ! [ -z "${ARCHIVE}" ]; then
  tar -czf wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz .
  mv wrfout_${YEAR}_${MONTH}_${DAY}_${HOUR}.tar.gz "${ARCHIVE}"
fi
