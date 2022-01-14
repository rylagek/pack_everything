# Install vbox keys
mkdir /home/vbox/.ssh
chmod 700 /home/vbox/.ssh
cd /home/vbox/.ssh
fetch -am -o authorized_keys 'https://raw.github.com/mitchellh/vbox/master/keys/vbox.pub'
chown -R vbox /home/vbox/.ssh

#Set the time correctly
ntpdate -v -b in.pool.ntp.org
date > /etc/vbox_box_build_time
