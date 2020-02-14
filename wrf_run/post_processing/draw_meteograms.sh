#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-07-03 18:01:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-13 21:19:56

# script to generate output meteograms from a model run
# ${1}: the year for the model run
# ${2}: the month for the model run
# ${3}: the day for the model run
# ${4}: the hour of the model run
# ${5}: the timespan for the model run
# ${6}: the destination folder of the output

# setting -e to abort on error
set -e

generate_meteogram () {
  METEO_TITLE=${1}
  LOC_SHORTCUT=${2}
  INPUT_FILE=${2}.d01.TS

  # move required meteogram files to output folder
  mv "${BUILD_PATH}/WRF/test/em_real/${LOC_SHORTCUT}".* "${HOME}/wrf_output"

  ncl time_array="${LEGEND_ARRAY}" ticks="${TICK_ARRAY}" sticks="${STICK_ARRAY}" title=\""${METEO_TITLE}"\" input=\""${INPUT_FILE}"\" plot_T_timeline  >> "${DEBUG_LOG}"
  ncl time_array="${LEGEND_ARRAY}" ticks="${TICK_ARRAY}" sticks="${STICK_ARRAY}" title=\""${METEO_TITLE}"\" input=\""${INPUT_FILE}"\" plot_meteogram  >> "${DEBUG_LOG}"

  # mkdir ${DEST_FOLDER}/
  # mv time_T2.png ${DEST_FOLDER}/${DEST_PREFIX}_time_T2_${LOC_SHORTCUT}.png
  # mv meteo.png ${DEST_FOLDER}/${DEST_PREFIX}_meteogram_${LOC_SHORTCUT}.png

  # optimize png size
  find . -maxdepth 1 -name '*.png' -exec optipng {} \;

  # move files to output folder
  mv time_T2.png "${DEST_FOLDER}/${DEST_PREFIX}_time_T2_${LOC_SHORTCUT}.png"
  mv meteo.png "${DEST_FOLDER}/${DEST_PREFIX}_meteogram_${LOC_SHORTCUT}.png"
}

# define terminal colors
source ${COLOR_PATH}

# error handling for input parameter
if [ "$#" -ne 6 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR> <PERIOD> <DEST_FOLDER>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# logging time stamp
now=$(date +"%T")
printf "Starting meteograms at %s.\\n" "${now}" >> "${INFO_LOG}"

cd "${HOME}/wrf_output" || exit 1

DATE=${1}-${2}-${3}
START_DATE=$(LC_ALL=en_UTF-8 date +\(%Y-%m-%d-%HUTC\) -d "${DATE}T${4}:00")
DATE_FORMAT="+%b-%d/00"
LEGEND_ARRAY="(/\"$(LC_ALL=en_UTF-8 date ${DATE_FORMAT} -d "${DATE} + 1 day")\""

MAIN_HOURS="$((24 - ${4}))"
TICK_ARRAY="(/${MAIN_HOURS}"

SEC_HOURS="$((12 - ${4}))"
STICK_ARRAY="(/${SEC_HOURS}"

for i in {2..8}
do
  NEXT_DATE=$(LC_ALL=en_UTF-8 date ${DATE_FORMAT} -d "${DATE} + ${i} day")
  SEC_HOURS="$((${MAIN_HOURS}+12))"
  STICK_ARRAY+=","
  STICK_ARRAY+="${SEC_HOURS}"
  MAIN_HOURS="$((${MAIN_HOURS}+24))"
  LEGEND_ARRAY+=","
  LEGEND_ARRAY+="\"${NEXT_DATE}\""
  TICK_ARRAY+=","
  TICK_ARRAY+="${MAIN_HOURS}"
done

LEGEND_ARRAY+="/)"
TICK_ARRAY+="/)"
STICK_ARRAY+="/)"

DEST_PREFIX=${2}_${3}_${4}
DEST_FOLDER=${6}

generate_meteogram "Hannover,_NDS_${START_DATE}" "Han"
generate_meteogram "Ith-Zeltplatz,_NDS_${START_DATE}" "Ith"
generate_meteogram "Husum,_SH_${START_DATE}" "Hus"

# logging time stamp
now=$(date +"%T")
printf "Finished meteograms at %s.\\n" "${now}" >> "${INFO_LOG}"
