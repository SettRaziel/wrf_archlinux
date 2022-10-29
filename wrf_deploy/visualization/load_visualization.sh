#!/bin/bash

# enable termination on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

SCRIPT_PATH=$(pwd)

# switch to home folder
cd "${HOME}"

# clone wrf_visualization project
if ! [ -d "${HOME}/wrf_visualization" ]; then
  printf "%b\\nCloning wrf_visualization: %b\\n" "${YELLOW}" "${NC}"
  git clone "https://github.com/SettRaziel/wrf_visualization.git"
fi

# checkout master, since it holds the latest version tag
cd wrf_visualization
printf "%b\\nChecking wrf_visualization: %b\\n" "${YELLOW}" "${NC}"
git checkout master  
git pull

# init python dependencies
printf "%b\\nRunning initialization scripts: %b\\n" "${YELLOW}" "${NC}"
cd init || exit 1
sh ./init_environment.sh

printf "%b\\nFinished setup for wrf_visualization.%b\\n" "${YELLOW}" "${NC}"
cd "${SCRIPT_PATH}"
