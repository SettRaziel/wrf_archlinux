#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-04-26 18:27:28

BUILD_PATH=${HOME}/Build_WRF
GFS_PATH=$1

source ./set_env.sh

sh clean_up.sh $BUILD_PATH

sh ./pre_processing.sh $BUILD_PATH ${GFS_PATH}
