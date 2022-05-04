#!/bin/sh

# Exit on failure
set -e
# Show commands on screen
set -x

# Default to /dev/sda
# Not sure how portable this is. I think on vSphere it might need to be /dev/vda?
DEVICE="${1:-/dev/sda}"


# Set system clock
timedatectl set-ntp true

./partition.sh "${DEVICE}"

# TODO determine what packages we actually need
pacstrap /mnt base linux linux-firmware

genfstab -t UUID /mnt >> /mnt/etc/fstab

# Installs bootloader
cp bootloader.sh /mnt/
arch-chroot /mnt /bootloader.sh
rm /mnt/bootloader.sh

# Sets up password and ssh
cp packer.sh /mnt/
arch-chroot /mnt /packer.sh
rm /mnt/packer.sh

umount -R /mnt
sudo systemctl reboot

