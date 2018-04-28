#!/usr/bin/env bash

# Set up host key for root, put keys in resources/authorized_keys
if [ -s /tmp/resources/authorized_keys ]; then
  mkdir -p /root/.ssh
  cp -f /tmp/resources/authorized_keys /root/.ssh
fi

# Allow root to login with key
sed -i -e 's/^PermitRootLogin (yes|no)$/\#PermitRootLogin no/' /etc/ssh/sshd_config
echo "PermitRootLogin without-password" >> /etc/ssh/sshd_config

# Only allow other users to login with key
sed -i -e 's/^PasswordAuthentication yes$//' /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Install modded bashrc
cp -f /tmp/resources/.bashrc ~/.bashrc

# Set bashrc for non-root users
echo 'PS1="${debian_chroot:+($debian_chroot)}\\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ "' >> /etc/skel/.bashrc

# Setup vimrc
cp -f /tmp/resources/.vimrc /root
cp -f /tmp/resources/.vimrc /etc/skel

# Install base packages
yum check-update
yum -y update
yum -y install epel-release 
yum -y install rsync wget curl screen vim lynx sudo firewalld net-tools mlocate gawk 