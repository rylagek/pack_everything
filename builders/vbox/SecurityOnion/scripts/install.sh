#!/bin/bash
echo "Installing via so-setup"
pwd
echo "automation" | sudo -S yum -y install screen
echo "automation" | sudo -S screen -DmS installation SecurityOnion/setup/so-setup iso ucwt-iso
echo "Finished installing via so-setup"
