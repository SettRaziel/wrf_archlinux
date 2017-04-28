#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-12 09:26:31
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-04-28 23:18:38

BUILD_PATH=$1
GFS_PATH=$2

source ./set_env.sh

sh clean_up.sh $BUILD_PATH

sh ./pre_processing.sh $BUILD_PATH ${GFS_PATH}
