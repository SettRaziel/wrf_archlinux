#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-03 09:47:13
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-09-03 12:14:29

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

cd ./wrf_postprocessing
sh ncl_install.sh
