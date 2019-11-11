#!/bin/sh
# @Author: Benjamin Held
# @Date:   2019-10-13 09:11:54
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-11-11 16:30:47

# Script that sets the required variables for the model deployment
# ${1}: the value for the WRF model version
# ${2}: the value for the WRF geo data


# default WRFV4 model
export WRF_VERSION_INDEX=${1}
# default low resolution WRFV4 geo data
export WRF_GEODATA_INDEX=${2}
