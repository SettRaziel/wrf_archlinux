#!/bin/bash

# define terminal colors
. "${COLOR_PATH}"

# script that generates a meta.ini for the minimal php gui
# ${1}: the year for the model run
# ${2}: the month for the model run
# ${3}: the day for the model run
# ${4}: the hour of the model run
# ${5}: the timespan for the model run
# ${6}: the destination folder of the output

# parameter check
if [ "$#" -ne 6 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR> <PERIOD> <DEST_FOLDER>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

DATE="${1}-${2}-${3}T${4}:00UTC"
START_DATE=$(date -u +%s -d "${DATE}")
END_DATE=$(date -u +%s -d "${DATE} +${5} hour")

FILEPATH="${6}/meta.ini"

# function to write the content of the meta.ini
print_ini() {
echo "start = ${START_DATE}"
echo "end = ${END_DATE}"
echo "period = $((${1} * 3600))"
echo

echo 'locations[Han] = "Hannover, Germany"'
echo 'locations[Ith] = "Ith-Zeltplatz, Germany"'
echo

echo '[comp]'
echo 'delta=10800'
echo 'files=comp/comp_%Y_%m_%d_%H.png'
echo 'desc="Komposition von Temperatur, Luftdruck und Wind vom %Y-%m-%d %H:00 UTC"'
echo 'title="Multidiagramm"'
echo

echo '[rain_3h]'
echo "start=$(date -u +%s -d "${DATE} + 3 hour")"
echo 'delta=10800'
echo 'files=rain_3h/rain_3h_%Y_%m_%d_%H.png'
echo 'desc="3stündiger Niederschlag vom %Y-%m-%d %H:00 UTC"'
echo 'title="Niederschlag 3 h"'
echo

echo '[rain_tot]'
echo "start=$(date -u +%s -d "${DATE} + 6 hour")"
echo 'delta=21600'
echo 'files=rain_tot/rain_tot_%Y_%m_%d_%H.png'
echo 'desc="Gesamtniederschlag bis zum %Y-%m-%d %H:00 UTC"'
echo 'title="Summe Niederschlag"'
echo

echo '[thunderstorm_index]'
echo 'delta=10800'
echo 'files=thunderstorm_index/thunderstorm_%Y_%m_%d_%H.png'
echo 'desc="CAPE Index vom %Y-%m-%d %H:00 UTC"'
echo 'title="Gewitter Index"'
echo

echo '[meteogram]'
echo 'scope="locations"'
echo 'files=%m_%d_%H_meteogram_%x.png'
echo 'desc="Meteogramm für %X ab %Y-%m-%d %H:00 UTC"'
echo 'title="Meteogramm %x"'
echo

echo '[temperature]'
echo 'scope="locations"'
echo 'files=%m_%d_%H_time_T2_%x.png'
echo 'desc="Temperatur in 2m Höhe für %X ab %Y-%m-%d %H:00 UTC"'
echo 'title="Temperatur %x"'
}

print_ini "${5}" > "${FILEPATH}"
