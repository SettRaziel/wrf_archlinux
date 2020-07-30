#!/bin/sh
# @Author: Benjamin Held
# @Date:   2020-05-22 18:53:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-07-30 20:15:04

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# logging time stamp
printf "Starting postprocessing activities at %s.\\n" "$(date +"%T")"

# IMPLEMENT YOUR POSTPROCESSING SCRIPT CALLS HERE

# logging time stamp
printf "Finished postprocessing activities at %s.\\n" "$(date +"%T")"
