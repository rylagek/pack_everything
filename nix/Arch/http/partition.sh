#!/bin/sh

set -e
set -x

DEVICE=$1

boot_partition="${DEVICE}1"
swap_partition="${DEVICE}2"
root_partition="${DEVICE}3"

parted "${DEVICE}" --script mklabel gpt
parted "${DEVICE}" --script --align=optimal mkpart primary ext2 1MiB 500MiB
parted "${DEVICE}" --script set 1 boot on
parted "${DEVICE}" --script --align=optimal mkpart primary linux-swap 500MiB 1GiB
parted "${DEVICE}" --script --align=optimal mkpart primary ext4 1GiB 100%

mkfs.ext2 -L 'boot' "${boot_partition}"
mkswap "${swap_partition}"
swapon "${swap_partition}"
mkfs.ext4 -L 'root' "${root_partition}"

mount "${root_partition}" /mnt
mkdir /mnt/boot
mount "${boot_partition}" /mnt/boot

