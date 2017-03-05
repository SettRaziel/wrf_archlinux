#!/bin/sh
# @Author: Benjamin Held; based on the WRF OnlineTutorial
# @Date:   2017-02-18 21:23:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-05 20:13:08

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

printf "${YELLOW}Starting PreCompile from: ${NC}\n"
printf "${LIGHT_BLUE}http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php${NC}\n"
printf "${RED}Requires: netcdf and openmpi.${NC}\n"

# Creating required folders
mkdir ~/$1/lib_test
cp ~/$1/Fortran_C_NETCDF_MPI_tests.tar ~/$1/lib_test/
cd ~/$1/lib_test

# Unpacking test files
printf "${YELLOW}Unpacking test files: ${NC}\n"
tar -xf Fortran_C_NETCDF_MPI_tests.tar

# Running first test
printf "${YELLOW}Running first test: TEST_1_fortran_only_fixed ${NC}\n"
cp ${NETCDF}/include/netcdf.inc .
gfortran -c 01_fortran+c+netcdf_f.f
gcc -c 01_fortran+c+netcdf_c.c
gfortran 01_fortran+c+netcdf_f.o 01_fortran+c+netcdf_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
./a.out
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Running second test
printf "${YELLOW}Running second test: TEST_2_fortran_only_free ${NC}\n"
mpif90 -c 02_fortran+c+netcdf+mpi_f.f
mpicc -c 02_fortran+c+netcdf+mpi_c.c
mpif90 02_fortran+c+netcdf+mpi_f.o 02_fortran+c+netcdf+mpi_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
mpirun ./a.out &> out.log
cat out.log
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Cleaning up
cd ..
rm -r ~/$1/lib_test
