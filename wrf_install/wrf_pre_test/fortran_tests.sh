#!/bin/sh
# @Author: Benjamin Held; based on the WRF OnlineTutorial
# @Date:   2017-02-18 21:23:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-03 21:24:43

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

printf "${YELLOW}Starting PreCompile Fortran tests from: ${NC}\n"
printf "${LIGHT_BLUE}http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php${NC}\n"
printf "${RED}Requires: gfortran, cpp, gcc, tcsh, perl and sh.${NC}\n"

# Creating required folders
mkdir ~/$1/fortran_test
cp ~/$1/Fortran_C_tests.tar ~/$1/fortran_test/
cd ~/$1/fortran_test

# Unpacking test files
printf "${YELLOW}\nUnpacking test files: ${NC}\n"
tar -xf Fortran_C_tests.tar

# Running first test
printf "${YELLOW}\nRunning first test: TEST_1_fortran_only_fixed ${NC}\n"
gfortran TEST_1_fortran_only_fixed.f
./a.out
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Running second test
printf "${YELLOW}\nRunning second test: TEST_2_fortran_only_free ${NC}\n"
gfortran TEST_2_fortran_only_free.f90
./a.out
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Running third test
printf "${YELLOW}\nRunning third test: TEST_3_c_only ${NC}\n"
gcc TEST_3_c_only.c
./a.out
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Running fourth test
printf "${YELLOW}\nRunning fourth test: C function called by Fortran ${NC}\n"
gcc -c -m64 TEST_4_fortran+c_c.c
gfortran -c -m64 TEST_4_fortran+c_f.f90
gfortran -m64 TEST_4_fortran+c_f.o TEST_4_fortran+c_c.o
./a.out
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Running fifth test
printf "${YELLOW}\nRunning fifth test: csh functionality ${NC}\n"
./TEST_csh.csh
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Running sixth test
printf "${YELLOW}\nRunning sixth test: perl functionality ${NC}\n"
./TEST_perl.pl
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Running seventh test
printf "${YELLOW}\nRunning seventh test: shell functionality ${NC}\n"
./TEST_sh.sh
printf "${LIGHT_BLUE}finished test. ${NC}\n"

# Cleaning up
cd ..
rm -r ~/$1/fortran_test
