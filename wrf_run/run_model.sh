#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-18 09:40:15
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-30 21:17:24

GFS_PATH="~/gfs_data"
BUILD_PATH="~/Build_WRF"
SCRIPT_PATH=$(pwd)

source ../wrf_install/linux/set_env.sh

# adjusting namelist for next run
sh ./prepare_namelist.sh $1 $2 $3 $4

# fetching input data
cd $SCRIPT_PATH
sh ./data_fetch/gfs_fetch.sh "$1$2$3" $4 $GFS_PATH

# start model run
cd $SCRIPT_PATH
sh ./model_run/pre_processing.sh $BUILD_PATH $GFS_PATH
