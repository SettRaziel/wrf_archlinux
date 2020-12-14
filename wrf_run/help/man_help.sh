# @Author: Benjamin Held
# @Date:   2020-12-14 17:54:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-12-14 18:38:11

. "${COLOR_PATH}"

printf "%bscript usage:%b ./run_model.sh [parameter]\\n" "${GREEN}" "${NC}"
printf "%bModel run parameter:\\n%b" "${YELLOW}" "${NC}"
printf "%b     --help      %b   show help text\\n" "${LIGHT_BLUE}" "${NC}"
printf "%b -b, --build     %b   argument: <path>%b; specifies the wrf path\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "%b -y, --year      %b   argument: <year>%b; the model year\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "%b -m, --month     %b   argument: <month>%b; the model month\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "%b -d, --day       %b   argument: <day>%b; the model day\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "%b -h, --hour      %b   argument: <hour>%b; the model hour\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "%b -p, --period    %b   argument: <period>%b; the forecast duration\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "%b -r, --resolution%b   argument: <resolution>%b; the model resolution\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
