#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-06 19:18:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-06-14 18:23:40

# This script loads the required input data for a 180 h forecast run
# $1 matches the required date yyyymmdd
# $2 matches the required timestamp
# $3 is the storage path
# $4 is the model resolution [0p25, 0p50, 1p00]
# $5 the time period for the model run

# logging time stamp
now=$(date +"%T")
printf "Starting gfs data fetching at ${now}.\n" > ${LOG_PATH}/log.info

# Remove old files
rm ${3}/gfs.*

# Fetch the new ones
for i in $(seq -f %03g 0 3 ${5}); do
wget -q -P ${3} https://para.nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/para/gfs.${1}${2}/gfs.t${2}z.pgrb2.${4}.f${i}
done

# Check and continue broken files
for i in $(seq -f %03g 0 3 ${5}); do
wget -c -q -P ${3} https://para.nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/para/gfs.${1}${2}/gfs.t${2}z.pgrb2.${4}.f${i}
done
