# @Author: Benjamin Held
# @Date:   2018-11-15 18:08:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-12-07 23:26:57

# check and load required packages
sh load_packages.sh

# create neccessary directories
sh create_directories.sh

# load and unpack the neccessary geodata, WRFV3 minimal
sh load_geodata.sh 2

# load and unpack the wrf archive, version 3.9.1
sh load_wrf.sh 1
