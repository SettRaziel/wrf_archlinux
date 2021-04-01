#!/bin/bash

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# logging time stamp
printf "Starting postprocessing activities at %s.\\n" "$(date +"%T")"

# IMPLEMENT YOUR POSTPROCESSING SCRIPT CALLS HERE

# logging time stamp
printf "Finished postprocessing activities at %s.\\n" "$(date +"%T")"
