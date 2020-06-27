#!/bin/sh
# @Author: Benjamin Held; based on the WRF OnlineTutorial
# @Date:   2017-02-18 21:23:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-06-27 09:14:24

# script with pre compile function tests
# ${1}: path to the installation folder

# define terminal colors
. ../../libs/terminal_color.sh

# setting -e to abort on error
set -e

# storing current script path
SCRIPT_PATH=$(pwd)

printf "%bStarting PreCompile from: %b\\n" "${YELLOW}" "${NC}"
printf "%bhttp://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php%b\\n" "${LIGHT_BLUE}" "${NC}"
printf "%bRequires: netcdf and openmpi.%b\\n" "${RED}" "${NC}"

# creating required folders
mkdir "${HOME}/${1}/lib_test"
cd "${HOME}/${1}/lib_test" || exit 1
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_NETCDF_MPI_tests.tar

# unpacking test files
printf "%bUnpacking test files: %b\\n" "${YELLOW}" "${NC}"
tar -xf Fortran_C_NETCDF_MPI_tests.tar

# running first test
printf "%bRunning first test: TEST_1_fortran_only_fixed %b\\n" "${YELLOW}" "${NC}"
cp "${NETCDF}/include/netcdf.inc" . || exit 1
gfortran -c 01_fortran+c+netcdf_f.f
gcc -c 01_fortran+c+netcdf_c.c
gfortran 01_fortran+c+netcdf_f.o 01_fortran+c+netcdf_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
./a.out
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# running second test
printf "%bRunning second test: TEST_2_fortran_only_free %b\\n" "${YELLOW}" "${NC}"
mpif90 -c 02_fortran+c+netcdf+mpi_f.f
mpicc -c 02_fortran+c+netcdf+mpi_c.c
mpif90 02_fortran+c+netcdf+mpi_f.o 02_fortran+c+netcdf+mpi_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
mpirun ./a.out &> out.log
cat out.log
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# cleaning up
cd .. || exit 1
rm -r "${HOME}/${1}/lib_test"
cd "${SCRIPT_PATH}" || exit 1
