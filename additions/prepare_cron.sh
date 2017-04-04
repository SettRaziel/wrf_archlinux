#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-04-04 19:57:11
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-04-04 20:04:46

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# install cron package
yaourt -S cronie

# enable cron service on start
sudo systemctl enable cronie.service

# start cron service
sudo systemctl start cronie.service

printf "${YELLOW}Define crontabs, e.g. daily modelrun for 18 UTC data at midnight\n${NC}"
printf "${YELLOW}crontab -u http -e 00 00 * * * /abs_path/to/run_model.sh 18${NC}"

crontab -l
