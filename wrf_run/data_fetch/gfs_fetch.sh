#!/bin/bash

# This script loads the required input data for a 180 h forecast run
# ${1} matches the required date yyyymmdd
# ${2} matches the required timestamp
# ${3} is the storage path
# ${4} is the model resolution [0p25, 0p50, 1p00]
# ${5} the time period for the model run

# define terminal colors
. "${COLOR_PATH}"

# parent url to the noaa data server as of 2020-06-01
# source: https://www.nco.ncep.noaa.gov/pmb/products/gfs/#GFS
GFS_URL="https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/"

# function to fetch the input data with curl
gfs_fetch_curl () {
  # Define a number of retries and try to download the files
	for i in $(seq -f %03g 0 3 "${5}"); do
    RETRIES=0
	  while [ "${RETRIES}" -lt 10 ]; do
      # -w return http code, -C continue if interrupted, -o define output; loop breaks if file was loaded successfully
      RETURN_CODE=$(curl -w "%{http_code}\n" -C - -o "${3}"/gfs.t"${2}"z.pgrb2."${4}".f"${i}" "${GFS_URL}"gfs."${1}"/"${2}"/atmos/gfs.t"${2}"z.pgrb2."${4}".f"${i}")
      if [[ "${RETURN_CODE}" -eq 200 ]]; then
        break
      fi

      ((RETRIES++))

      # in addition to the http codes curl returns 000 if it ran into a timeout
      if [[ "${RETURN_CODE}" =~ [4-5][0-9]{2}$ ]] || [[ "${RETURN_CODE}" =~ [0]{3}$ ]]; then
        if [[ "${RETURN_CODE}" =~ [0]{3}$ ]]; then
          RETURN_CODE="Timeout"
        fi
        printf "Inputfile for %d failed with %s at %s.\\n" "${i}" "${RETURN_CODE}" "$(date +"%T")" >> "${INFO_LOG}"
      fi

	  done

    if [[ "${RETRIES}" -eq 10 ]]; then
      printf "Error while downloading %d at %s.\\n" "${i}" "$(date +"%T")" >> "${INFO_LOG}"
      exit 1
    fi
	done
}

# function to fetch the input data with wget
gfs_fetch_wget () {
  # Fetch the new input files
  for i in $(seq -f %03g 0 3 "${5}"); do
    wget -q -P "${3}" "${GFS_URL}"gfs."${1}"/"${2}"/atmos/gfs.t"${2}"z.pgrb2."${4}".f"${i}"
  done

  # Check and continue broken files
  for i in $(seq -f %03g 0 3 "${5}"); do
    wget -c -q -P "${3}" "${GFS_URL}"gfs."${1}"/"${2}"/atmos/gfs.t"${2}"z.pgrb2."${4}".f"${i}"
  done
}

# backup function to fetch the input data from the ftp server with curl
gfs_ftp_fetch_curl () {
  GFS_URL="ftp://ftp.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/"
  # Define a number of retries and try to download the files
  for i in $(seq -f %03g 0 3 "${5}"); do
    RETRIES=0
    while [ "${RETRIES}" -lt 10 ]; do
      # -f fail silenty, -C continue if interrupted, -o define output; loop breaks if file was loaded successfully
      curl -f -C - -o "${3}"/gfs.t"${2}"z.pgrb2."${4}".f"${i}" "${GFS_URL}"gfs."${1}"/"${2}"/atmos/gfs.t"${2}"z.pgrb2."${4}".f"${i}" && break
      $((RETRIES++))
    done
    if ![[ "${RETRIES}" -eq 10 ]]; then
      printf "Error while downlaoding %d at %s.\\n" "${i}" "$(date +"%T")" >> "${INFO_LOG}"
      exit 1
    fi
  done
}

# error handling for input parameter
if [ "$#" -ne 5 ]; then
  printf "%bWrong number of arguments. Must be one for <DATE> <TIMESTAMP> <STORAGE_PATH> <GEO_RESOLUTION> <PERIOD>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# logging time stamp
printf "Starting gfs data fetch by removing old files at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"

# Remove old gfs files
rm "${3}"/gfs.*

printf "Starting gfs data fetching at %s.\\n" "$(date +"%T")" >> "${INFO_LOG}"

# use fetch via curl at this point
gfs_fetch_curl "${1}" "${2}" "${3}" "${4}" "${5}"
