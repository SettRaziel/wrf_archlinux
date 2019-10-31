#!/bin/sh
# @Author: Benjamin Held; based on the WRF OnlineTutorial
# @Date:   2017-02-18 21:23:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-31 16:41:04

# installation of the netcdf package
# ${1}: path to the installation folder

# define terminal colors
source ../../libs/terminal_color.sh

# setting -e to abort on error
set -e

# storing current script path
SCRIPT_PATH=$(pwd)

printf "${YELLOW}Starting PreCompile from: ${NC}\\n"
printf "${LIGHT_BLUE}http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php${NC}\\n"
printf "${RED}Requires: netcdf and openmpi.${NC}\\n"

# Creating required folders
mkdir ${HOME}/${1}/lib_test
cd ${HOME}/${1}/lib_test
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_NETCDF_MPI_tests.tar

# Unpacking test files
printf "${YELLOW}Unpacking test files: ${NC}\\n"
tar -xf Fortran_C_NETCDF_MPI_tests.tar

# Running first test
printf "${YELLOW}Running first test: TEST_1_fortran_only_fixed ${NC}\\n"
cp ${NETCDF}/include/netcdf.inc .
gfortran -c 01_fortran+c+netcdf_f.f
gcc -c 01_fortran+c+netcdf_c.c
gfortran 01_fortran+c+netcdf_f.o 01_fortran+c+netcdf_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
./a.out
printf "${LIGHT_BLUE}finished test. ${NC}\\n"

# Running second test
printf "${YELLOW}Running second test: TEST_2_fortran_only_free ${NC}\\n"
mpif90 -c 02_fortran+c+netcdf+mpi_f.f
mpicc -c 02_fortran+c+netcdf+mpi_c.c
mpif90 02_fortran+c+netcdf+mpi_f.o 02_fortran+c+netcdf+mpi_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
mpirun ./a.out &> out.log
cat out.log
printf "${LIGHT_BLUE}finished test. ${NC}\\n"

# Cleaning up
cd ..
rm -r ${HOME}/${1}/lib_test
cd ${SCRIPT_PATH}
