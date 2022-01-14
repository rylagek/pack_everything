#!/bin/bash

date > /etc/vbox_build_time

VBOX_USER=vbox
VBOX_HOME=/home/$VBOX_USER

# Create Vagrant user (if not already present)
if ! id -u $VBOX_USER >/dev/null 2>&1; then
    echo "==> Creating $VBOX_USER user"
    /usr/sbin/groupadd $VBOX_USER
    /usr/sbin/useradd $VBOX_USER -g $VBOX_USER -G sudo -d $VBOX_HOME --create-home
    echo "${VBOX_USER}:${VBOX_USER}" | chpasswd
fi

# Set up sudo
echo "==> Giving ${VBOX_USER} sudo powers"
echo "${VBOX_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

echo "==> Installing vagrant key"
mkdir $VBOX_HOME/.ssh
chmod 700 $VBOX_HOME/.ssh
cd $VBOX_HOME/.ssh
# https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
mkdir -p /mnt/floppy
modprobe floppy
mount -t vfat /dev/fd0 /mnt/floppy
cp /mnt/floppy/vagrant.pub $VBOX_HOME/.ssh/authorized_keys
umount /mnt/floppy
rmdir /mnt/floppy
chmod 600 $VBOX_HOME/.ssh/authorized_keys
chown -R $VBOX_USER:$VBOX_USER $VBOX_HOME/.ssh
