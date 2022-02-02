#!/bin/sh

set -e
set -x

passwd <<PASSWD
arch
arch
PASSWD

pacman --sync --needed --noconfirm openssh dhcpcd sudo
systemctl enable sshd
systemctl enable dhcpcd

cat <<SSHCONF >> /etc/ssh/sshd_config
PermitRootLogin yes
SSHCONF
