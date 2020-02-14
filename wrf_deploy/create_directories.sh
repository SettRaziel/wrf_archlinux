#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-09-15 11:49:35
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-10 16:41:37

#script to create the required directories

# storage folder for the gfs input data
mkdir ${HOME}/gfs_data

# storage folder for the wrf output data and ncl scripts
mkdir ${HOME}/wrf_output

# copy ncl scripts to output folder
cp ../plots/* ${HOME}/wrf_output
