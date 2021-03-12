# @Author: Benjamin Held
# @Date:   2021-03-08 19:29:37
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-03-12 18:49:31

ERROR_STATUS="${1} at: $(date +"%T")."
YEAR=${2}
MONTH=${3}
DAY=${4}
HOUR=${5}

SCRIPT_PATH=$(pwd)
# log error informations
printf "%s\\n" "${ERROR_STATUS}" >> "${INFO_LOG}"
printf "Error: %s\\n" "${ERROR_STATUS}" >> "${STATUS_LOG}"

# store relevant error informations
cd "${LOG_PATH}" || exit 1
ERROR_DIR="error_${YEAR}_${MONTH}_${DAY}_${HOUR}"
if ! [ -d "${ERROR_DIR}" ]; then
  mkdir "${ERROR_DIR}"
fi
mv "${INFO_LOG}" "${ERROR_DIR}"
mv "${DEBUG_LOG}" "${ERROR_DIR}"

# copy wrf run files independent from the error source, if it breaks before the model run
# it is possible to get the files from the previous run
cp "${WRF_DIR}/test/em_real/real_error.log" "${ERROR_DIR}"
cp "${WRF_DIR}/test/em_real/rsl.error.0000" "${ERROR_DIR}"

# generate error mail
cd "${SCRIPT_PATH}" || exit 1
sh create_mail.sh "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "${ERROR_STATUS}" "Fail"

# check for error log and append error
if [ ! -f "${ERROR_LOG}" ]; then
  touch "${ERROR_LOG}"
fi

# check for empty hour
if [ -z "${HOUR}" ]; then
  HOUR="unknown hour"
else
  HOUR="${HOUR}:00"
fi
printf "Failed model run %s-%s-%s %s at %s.\\n" "${YEAR}" "${MONTH}" "${DAY}" "${HOUR}" "$(date +"%F %R")" >> "${ERROR_LOG}"

echo "${1}" 1>&2
