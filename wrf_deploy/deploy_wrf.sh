#!/bin/sh
# @Author: Benjamin Held
# @Date:   2018-11-15 18:08:23
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-11-09 12:49:51

# main script to deploy a pre compiled version of wrf
# Version 0.4.0
# created by Benjamin Held and other sources, June 2017

# enable termination on error
set -e

# set environment variables
sh set_env.sh

# check and load required packages
sh load_packages.sh

# create neccessary directories
sh create_directories.sh

# load and unpack the neccessary geodata, WRFV4 minimal
sh load_geodata.sh

# load and unpack the wrf archive, version 4.0.2
sh load_wrf.sh
