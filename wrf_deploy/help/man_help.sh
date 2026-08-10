#!/bin/bash

# define terminal colors
. ../../libs/terminal_color.sh

printf "%bscript usage:%b ./deploy_wrf.sh [parameter]\\n" "${GREEN}" "${NC}"
printf "%bDeploy parameter:\\n%b" "${YELLOW}" "${NC}"
printf "%b     --help      %b   show help text\\n" "${LIGHT_BLUE}" "${NC}"
printf "%b     --default   %b   runs the deployment with default settings WRF 4.6 low data\\n" "${LIGHT_BLUE}" "${NC}"
printf "%b -v, --version   %b   argument: <index>%b; specifies the wrf version\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "                    1: 4.8, 2: 4.7, 3: 4.6, 4: 4.5, 5: 4.4\\n"
printf "%b -g, --geodata   %b   argument: <index>%b; specifies the wrf geodata\\n" "${LIGHT_BLUE}" "${RED}" "${NC}"
printf "                    1: WRF4 high, 2: WRF4 low\\n"
