#!/bin/sh
# @Author: benjamin
# @Date:   2017-09-06 21:17:50
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-28 13:39:45

# script to generate a notification email if the model run ends
# ${1}: the year for the model run
# ${2}: the month for the model run
# ${3}: the day for the model run
# ${4}: the hour of the model run
# ${5}: the reason text of the email
# ${6}: the outcome of the model run {Success, Fail}

# define terminal colors
. "${COLOR_PATH}"

# error handling for input parameter
if [ "$#" -ne 6 ]; then
  printf "%bWrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR> <REASON> <RESULT>.%b\\n" "${RED}" "${NC}"
  exit 1
fi

# function to create the mail text
create_mail () {
	echo "To: <recipient>"
	echo "From: <sender>"
	echo "Subject: WRF model run ${MONTH}/${DAY} ${HOUR}:00 (${RESULT})"
	echo
	echo "The model run from ${YEAR}/${MONTH}/${DAY} ${HOUR}:00 UTC has finished."
	echo "Result: ${REASON}"
	echo
	echo "Best wishes."
}

FILENAME="model_run.mail"
YEAR=${1}
MONTH=${2}
DAY=${3}
HOUR=${4}
REASON=${5}
RESULT=${6}

touch "${FILENAME}"
create_mail > "${FILENAME}"

cat "${FILENAME}" | msmtp -a default mail@recipient.domain
rm "${FILENAME}"
