#!/bin/sh

# setting -e to abort on error
set -e

# define terminal colors
. "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 6 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR> <PERIOD> <RESOLUTION>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# handle arguments
YEAR=${1}
MONTH=${2}
DAY=${3}
HOUR=${4}
PERIOD=${5}
RESOLUTION=${6}

# logging time stamp
SCRIPT_PATH=$(pwd)
printf "Starting post hook activities at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"

# IMPLEMENT YOUR POST HOOK SCRIPT CALLS HERE

# logging time stamp
printf "Finished post hook activities at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"
