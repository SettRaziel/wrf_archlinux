#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-04-04 19:57:11
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-10-30 21:59:40

source ../../libs/terminal_color.sh

# install cron package
yay -S cronie

# enable cron service on start
sudo systemctl enable cronie.service

# start cron service
sudo systemctl start cronie.service

printf "${YELLOW}Define crontabs, e.g. daily modelrun for 18 UTC data at midnight\\n${NC}"
printf "${YELLOW}crontab -u http -e 00 00 * * * /abs_path/to/run_model.sh 18\\n${NC}"

crontab -l
