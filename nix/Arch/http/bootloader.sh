#!/bin/sh

set -e
set -x

pacman --sync --noconfirm syslinux gptfdisk
syslinux-install_update -i -a -m
pacman --remove --cascade --recursive --nosave --noconfirm gptfdisk
