#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-07-03 18:01:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-03-27 19:45:46

function generate_meteogram () {
  METEO_TITLE=${1}
  LOC_SHORTCUT=${2}
  INPUT_FILE=${2}.d01.TS

  # example ncl call which prints a meteogram for the given file and input data
  #ncl time_array=${LEGEND_ARRAY} ticks=${TICK_ARRAY} sticks=${STICK_ARRAY} title=\"${METEO_TITLE}\" input=\"${INPUT_FILE}\" plot_meteogram  >> ${SCRIPT_PATH}/debug.log

  #move output to destination
}

set -e
source ${HOME}/scripts/set_env.sh

# logging time stamp
SCRIPT_PATH=$(pwd)
now=$(date +"%T")
printf "Starting meteograms at ${now}.\n" >> ${SCRIPT_PATH}/log.info

cd ${HOME}/<output_folder>

DATE=$1-$2-$3
START_DATE=$(LC_ALL=en_UTF-8 date +\(%Y-%m-%d-%HUTC\) -d "${DATE}T${4}:00")
DATE_FORMAT="+%b-%d/00"
# create an array with date stamps to show at the time axis
LEGEND_ARRAY="(/\"$(LC_ALL=en_UTF-8 date $DATE_FORMAT -d "$DATE + 1 day")\""

# create array for major tick mark positions at the beginning of a day
# add the first position based on the starting hour of the model run
MAIN_HOURS=`expr 24 - $4`
TICK_ARRAY="(/${MAIN_HOURS}"

# create arry for minor tick mark positions at midday
# add the first position based on the starting hour of the model run
SEC_HOURS=`expr 12 - $4`
STICK_ARRAY="(/${SEC_HOURS}"

# add the tick mark positions and time stamps for the following days
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

# conclude the array
LEGEND_ARRAY+="/)"
TICK_ARRAY+="/)"
STICK_ARRAY+="/)"

# when putting the output into time stamp based folder, this creates a folder
# prefix with mm_dd_hh/mm_dd_hh
DEST_PREFIX=${2}_${3}_${4}/${2}_${3}_${4}

# function call to draw the output for one specific place
generate_meteogram "Hannover,_Germany_${START_DATE}" "Han"

# logging time stamp
now=$(date +"%T")
printf "Finished meteograms at ${now}.\n" >> ${SCRIPT_PATH}/log.info
