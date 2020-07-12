#!/bin/sh
# @Author: Benjamin Held
# @Date:   2020-06-29 15:28:33
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-07-09 18:26:47

# enable termination on error
set -e

# define terminal colors
. ../libs/terminal_color.sh

SCRIPT_PATH=$(pwd)

# switch to home folder
cd "${HOME}" || exit 1

# clone wrf_visualization project
printf "%b\\nCloning wrf_visualization: %b\\n" "${YELLOW}" "${NC}"
git clone "https://github.com/SettRaziel/wrf_visualization.git"
# checkout master, since it holds the latest version tag
cd wrf_visualization || exit 1
git checkout master  

# init python dependencies
printf "%b\\nRunning initialization scripts: %b\\n" "${YELLOW}" "${NC}"
cd init || exit 1
sh ./init_environment.sh

printf "%b\\nFinished setup for wrf_visualization.%b\\n" "${YELLOW}" "${NC}"
cd "${SCRIPT_PATH}" || exit 1
