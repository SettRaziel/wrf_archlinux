#!/bin/bash

# Script that sets the required variables for the logging during the model run
# ${1}: the path where the run_model script is stored

. "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 1 ]; then
  printf "%bWrong number of arguments. Must be one for <SCRIPT_PATH>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# directory paths for logging files
export LOG_PATH="${1}/logs"
export DEBUG_LOG="${LOG_PATH}/debug.log"
export ERROR_LOG="${LOG_PATH}/error.log"
export INFO_LOG="${LOG_PATH}/info.log"
export STATUS_LOG="${LOG_PATH}/status.log"
