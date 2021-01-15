# @Author: Benjamin Held
# @Date:   2020-12-18 19:31:13
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-12-18 19:50:16

printf "%bscript usage:%b ./install.sh [parameter]\\n" "${GREEN}" "${NC}"
printf "%bInstall parameter:\\n%b" "${YELLOW}" "${NC}"
printf "%b     --help      %b   show help text\\n" "${LIGHT_BLUE}" "${NC}"
printf "%b -b, --build     %b   argument: <path>%b; specifies the wrf path\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "%b -l, --local     %b   uses local libraries for installation\\n" "${LIGHT_BLUE}" "${NC}"
