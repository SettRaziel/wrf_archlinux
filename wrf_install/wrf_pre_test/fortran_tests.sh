#!/bin/sh
# @Author: Benjamin Held; based on the WRF OnlineTutorial
# @Date:   2017-02-18 21:23:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-06-27 09:13:10

# define terminal colors
. ../../libs/terminal_color.sh

printf "%bStarting PreCompile Fortran tests from: %b\\n" "${YELLOW}" "${NC}"
printf "%bhttp://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php%b\\n" "${LIGHT_BLUE}" "${NC}"
printf "%bRequires: gfortran, cpp, gcc, tcsh, perl and sh.%b\\n" "${RED}" "${NC}"

# setting -e to abort on error
set -e

# storing current script path
SCRIPT_PATH=$(pwd)

# creating required folders and loading tests
mkdir "${HOME}/${1}/fortran_test"
cd "${HOME}/${1}/fortran_test" || exit 1
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_tests.tar

# unpacking test files
printf "%b\\nUnpacking test files: %b\\n" "${YELLOW}" "${NC}"
tar -xf Fortran_C_tests.tar

# running first test
printf "%b\\nRunning first test: TEST_1_fortran_only_fixed %b\\n" "${YELLOW}" "${NC}"
gfortran TEST_1_fortran_only_fixed.f
./a.out
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# running second test
printf "%b\\nRunning second test: TEST_2_fortran_only_free %b\\n" "${YELLOW}" "${NC}"
gfortran TEST_2_fortran_only_free.f90
./a.out
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# running third test
printf "%b\\nRunning third test: TEST_3_c_only %b\\n" "${YELLOW}" "${NC}"
gcc TEST_3_c_only.c
./a.out
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# running fourth test
printf "%b\\nRunning fourth test: C function called by Fortran %b\\n" "${YELLOW}" "${NC}"
gcc -c -m64 TEST_4_fortran+c_c.c
gfortran -c -m64 TEST_4_fortran+c_f.f90
gfortran -m64 TEST_4_fortran+c_f.o TEST_4_fortran+c_c.o
./a.out
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# running fifth test
printf "%b\\nRunning fifth test: csh functionality %b\\n" "${YELLOW}" "${NC}"
./TEST_csh.csh
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# running sixth test
printf "%b\\nRunning sixth test: perl functionality %b\\n" "${YELLOW}" "${NC}"
./TEST_perl.pl
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# running seventh test
printf "%b\\nRunning seventh test: shell functionality %b\\n" "${YELLOW}" "${NC}"
./TEST_sh.sh
printf "%bfinished test. %b\\n" "${LIGHT_BLUE}" "${NC}"

# rleaning up
cd .. || exit 1
rm -r "${HOME}/${1}/fortran_test"
cd "${SCRIPT_PATH}" || exit 1
