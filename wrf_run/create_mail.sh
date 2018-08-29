# @Author: benjamin
# @Date:   2017-09-06 21:17:50
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-08-29 19:30:36

function create_mail () {
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

touch ${FILENAME}
create_mail > ${FILENAME}

cat ${FILENAME} | msmtp -a default mail@recipient.domain
rm ${FILENAME}
