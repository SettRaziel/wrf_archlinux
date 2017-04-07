#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-02-26 14:21:00
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-04-07 23:32:05

# Simple script to copy the library or script files to its designated folders
mkdir ~/$1
cp -r $2/* ~/$1
