#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-07-03 18:01:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-04-15 18:21:51

function generate_meteogram () {
  METEO_TITLE=${1}
  LOC_SHORTCUT=${2}
  INPUT_FILE=${2}.d01.TS

  # move required meteogram files to output folder
  mv ${BUILD_PATH}/WRFV3/test/em_real/${LOC_SHORTCUT}.* ${HOME}/wrf_output

  ncl time_array=${LEGEND_ARRAY} ticks=${TICK_ARRAY} sticks=${STICK_ARRAY} title=\"${METEO_TITLE}\" input=\"${INPUT_FILE}\" plot_T_timeline  >> ${LOG_PATH}/debug.log
  ncl time_array=${LEGEND_ARRAY} ticks=${TICK_ARRAY} sticks=${STICK_ARRAY} title=\"${METEO_TITLE}\" input=\"${INPUT_FILE}\" plot_meteogram  >> ${LOG_PATH}/debug.log

  # mkdir ${DEST_FOLDER}/
  # mv time_T2.png ${DEST_FOLDER}/${DEST_PREFIX}_time_T2_${LOC_SHORTCUT}.png
  # mv meteo.png ${DEST_FOLDER}/${DEST_PREFIX}_meteogram_${LOC_SHORTCUT}.png

  # optimize png size
  find . -maxdepth 1 -name '*.png' -exec optipng {} \;

  # move files to output folder
  mv time_T2.png ${DEST_FOLDER}/${DEST_PREFIX}_time_T2_${LOC_SHORTCUT}.png
  mv meteo.png ${DEST_FOLDER}/${DEST_PREFIX}_meteogram_${LOC_SHORTCUT}.png
}

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting meteograms at ${now}.\n" >> ${LOG_PATH}/log.info

cd ${HOME}/wrf_output

DATE=$1-$2-$3
START_DATE=$(LC_ALL=en_UTF-8 date +\(%Y-%m-%d-%HUTC\) -d "${DATE}T${4}:00")
DATE_FORMAT="+%b-%d/00"
LEGEND_ARRAY="(/\"$(LC_ALL=en_UTF-8 date $DATE_FORMAT -d "$DATE + 1 day")\""

MAIN_HOURS=`expr 24 - $4`
TICK_ARRAY="(/${MAIN_HOURS}"

SEC_HOURS=`expr 12 - $4`
STICK_ARRAY="(/${SEC_HOURS}"

for i in {2..8}
do
  NEXT_DATE=$(LC_ALL=en_UTF-8 date $DATE_FORMAT -d "$DATE + $i day")
  SEC_HOURS=`expr $MAIN_HOURS + 12`
  STICK_ARRAY+=","
  STICK_ARRAY+="${SEC_HOURS}"
  MAIN_HOURS=`expr $MAIN_HOURS + 24`
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
printf "Finished meteograms at ${now}.\n" >> ${LOG_PATH}/log.info
