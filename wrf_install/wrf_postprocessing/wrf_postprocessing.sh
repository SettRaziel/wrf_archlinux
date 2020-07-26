# @Author: Benjamin Held
# @Date:   2020-05-22 18:53:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-07-26 15:44:49

# setting -e to abort on error
set -e

# define terminal colors
. ../../libs/terminal_color.sh

# logging time stamp
SCRIPT_PATH=$(pwd)
printf "Starting postprocessing activities at %s.\\n" "$(date +"%T")"

# IMPLEMENT YOUR POSTPROCESSING SCRIPT CALLS HERE

# logging time stamp
printf "Finished postprocessing activities at %s.\\n" "$(date +"%T")"
