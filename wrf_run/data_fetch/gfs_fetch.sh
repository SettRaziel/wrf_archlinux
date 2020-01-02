#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-06 19:18:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-12-05 18:10:57

# This script loads the required input data for a 180 h forecast run
# $1 matches the required date yyyymmdd
# $2 matches the required timestamp
# $3 is the storage path
# $4 is the model resolution [0p25, 0p50, 1p00]
# $5 the time period for the model run

sh ./gfs_fetch_curl.sh "${1}" "${2}" "${3}" "${4}" "${5}"
