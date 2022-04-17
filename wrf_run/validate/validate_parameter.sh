#!/bin/bash

# Script that validates if the given parameter are valid
# ${1}: the build path relativ from ${HOME} where the required wrf files
#       are installed; needs to be a path not equal to the default
# ${2}: the forecast period
# ${3}: the forecast resolution

BUILD_PATH="${1}" 
PERIOD="${2}"
RESOLUTION="${3}"
HOUR="${4}"

# check for modified build path
if [[ ${BUILD_PATH} == "<wrf path>" ]]; then
  exit 1
fi

# check if period parameter with value is given
if [ -z "${PERIOD}" ]; then
  exit 1
fi

# check if resolution parameter with value is given
if [ -z "${RESOLUTION}" ]; then
  exit 1
fi

# check if hour parameter with value is given
if [ -z "${HOUR}" ]; then
  exit 1
fi
