#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-26 14:21:00
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-05-26 18:16:45

# Simple script to copy the library or script files to its designated folders
mkdir ${HOME}/$1
cp -r $2/* ${HOME}/$1
