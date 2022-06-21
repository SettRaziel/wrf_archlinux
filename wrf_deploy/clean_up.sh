#!/bin/bash

# define terminal colors
. ../libs/terminal_color.sh

# package clean up if possible
printf "%b\\nLooking for removeable packages... %b\\n" "${YELLOW}" "${NC}"
PACKAGES=$(pacman -Qdtq)
if ! [ -z "${PACKAGES}" ]; then
  printf "%b\\nCleaning up packages: %s %b\\n" "${YELLOW}" "${PACKAGES}" "${NC}"
  sudo pacman --noconfirm -Rsn "${PACKAGES}"
fi
