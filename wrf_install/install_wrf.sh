#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-19 13:25:49
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-11 16:08:34

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

BUILD_PATH="<wrf path>"
HOME_PATH="/home/<user>/$BUILD_PATH"
SCRIPT_PATH=$(pwd)

# Preaparing files and folder
sh ./linux/preparations.sh $BUILD_PATH $SCRIPT_PATH/../../libs

# Install required basic packages
sh ./linux/basics.sh

# Setting required environment variables
cd $SCRIPT_PATH
source ./linux/set_env.sh $HOME_PATH

# Compiling netcdf bindings
sh ./wrf_preparation/netcdf.sh $BUILD_PATH

# Compiling fortran binding for netcdf
printf "${YELLOW}Starting fortran bindings in 5 seconds ... ${NC}"
sleep 5
sh ./wrf_preparation/fortran_bindings.sh $BUILD_PATH

# Compiling required libraries
printf "${YELLOW}Starting library compilation in 5 seconds ... ${NC}"
sleep 5
sh ./wrf_preparation/install_libraries.sh $BUILD_PATH

# Running System environment test
printf "${YELLOW}Starting fortran tests. Press any key ... ${NC}"
read
sh ./wrf_pre_test/fortran_tests.sh $BUILD_PATH

# Running Library compatibility test
printf "${YELLOW}Starting precompile tests. Press any key ... ${NC}"
read
sh ./wrf_pre_test/wrf_precompile_tests.sh $BUILD_PATH

# Compiling the wrf-model
printf "${YELLOW}Starting WRF compilation. Press any key ... ${NC}"
read
sh ./wrf_compile/compile_wrf.sh $BUILD_PATH $HOME_PATH

# Compiling the wps modulue
printf "${YELLOW}Starting WPS compilation in 5 seconds ... ${NC}"
sleep 5
sh ./wrf_compile/wps_compile.sh $BUILD_PATH
