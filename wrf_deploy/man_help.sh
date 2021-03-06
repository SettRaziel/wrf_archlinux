# @Author: Benjamin Held
# @Date:   2020-12-30 22:22:02
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-12-30 22:33:21

printf "%bscript usage:%b ./deploy_wrf.sh [parameter]\\n" "${GREEN}" "${NC}"
printf "%bDeploy parameter:\\n%b" "${YELLOW}" "${NC}"
printf "%b     --help      %b   show help text\\n" "${LIGHT_BLUE}" "${NC}"
printf "%b     --default   %b   runs the deployment with default settings WRF 4.2 low data\\n" "${LIGHT_BLUE}" "${NC}"
printf "%b -v, --version   %b   argument: <index>%b; specifies the wrf version\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "                    1: 4.2, 2: 4.1, 3: 4.0, 4: 3.9.1\\n"
printf "%b -g, --geodata   %b   argument: <index>%b; specifies the wrf geodata\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "                    1: WRF3 high, 2: WRF3 low, 3: WRF4 high, 4: WRF4 low\\n"
