#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-18 15:49:25
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-10 23:50:09

# Jump in folder and extract tar
cd ~/$1
tar -xf wrf-3.8.1.tar.bz2

# Build wrf
cd WRFV3
# Change the path according to the used user; configure requires an absolute
# path here or it fails with an error
sudo ln -s /bin/cpp /lib/cpp
ln -s $2/WRFV3/frame/ $2/WRFV3/external/
./configure
./clean
./compile -j 1 em_real >& ./compile.log

cd ..
