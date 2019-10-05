#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-26 17:34:20
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-05 08:57:47

# Script to compile the ncar command language for output visualization
# ${1}: the path to the folder where the ncl program should be installed

function load_zipfile () {
	FILE_NAME=${1}
	wget https://www.io-warnemuende.de/tl_files/staff/rfeistel/download/${FILE_NAME}.zip
	unzip ${FILE_NAME}.zip
	rm ${FILE_NAME}.zip
}

# define terminal colors
source ../../libs/terminal_color.sh

# latest version, marked deprecated in 09-2019
NCL_NAME='ncl_ncarg-6.6.2-Debian9.8_64bit_nodap_gnu630.tar.gz'

# Script to extract the optional ncl package for postprocessing
# Path to the library folder
cd ${DIR}

# checking unzip package
yay -S --needed unzip

# Unpacking ncl files
printf "${RED}\nAs of Sep 2019 ncl is no longer developed. Take this in mind, if you want to use that!${NC}\n"
printf "${YELLOW}\nUnpacking ncl.tar files: ${NC}\n"
mkdir ncl
cd ncl
wget https://www.earthsystemgrid.org/dataset/ncl.662_2.nodap/file/${NCL_NAME}
tar -xzf ${NCL_NAME}

# cleanup tar
rm ${NCL_NAME}

# Downloading detailed coastlines
mkdir ./lib/ncarg/database/rangs
cd ./lib/ncarg/database/rangs
load_zipfile "rangs(0)"
load_zipfile "rangs(1)"
load_zipfile "rangs(2)"
load_zipfile "rangs(3)"
load_zipfile "rangs(4)"
load_zipfile "gshhs(0)"
load_zipfile "gshhs(1)"
load_zipfile "gshhs(2)"
load_zipfile "gshhs(3)"
load_zipfile "gshhs(4)"

# Installing additional library
printf "${YELLOW}\nInstalling additional libraries: ${NC}\n"
yay -S --needed fontconfig libxrender libxtst
# Installing optipng to optimize png output size
yay -S --needed optipng

printf "${LIGHT_BLUE}\nFinished ncl preparations. ${NC}\n"
