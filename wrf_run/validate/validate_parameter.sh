# @Author: Benjamin Held
# @Date:   2020-12-15 19:11:26
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-12-15 19:33:20

# Script that validates if the given parameter are valid
# ${1}: the build path relativ from ${HOME} where the required wrf files
#       are installed; needs to be a path not equal to the default
# ${2}: the forecast period
# ${3}: the forecast resolution

BUILD_PATH="${1}" 
PERIOD="${2}"
RESOLUTION="${3}"

if [[ ${BUILD_PATH} == "<wrf path>" ]]; then
  exit 1
fi

if [ -z "${PERIOD}" ]; then
  exit 1
fi

if [ -z "${RESOLUTION}" ]; then
  exit 1
fi
