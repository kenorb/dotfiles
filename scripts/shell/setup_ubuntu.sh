#!/bin/sh
# Script which helps to configure Ubuntu for development
# Author: kenorb

#
# SERVICES
#
# OpenSSH server
sudo apt-get -y install openssh-server
# MySQL server
sudo apt-get -y install mysql-server mysql-client

#
# COMMON TOOLS
#
# Commonly used command lines
sudo apt-get -y install realpath
# Commonly used tools
sudo apt-get -y install screen mc
# For: sfill - secure free disk and inode space wiper
sudo apt-get -y install secure-delete
# Web tools
sudo apt-get -y install wget links lynx
# Media tools
sudo apt-get -y install youtube-dl
# File management tools
sudo apt-get -y install krusader

#
# DEVELOPMENT
#
# Common Linux development tools
sudo apt-get -y install autoconf libtool automake
# DevOps tools
sudo apt-get -y install puppet
sudo puppet module install puppetlabs/apt

#
# PROGRAMMING
#
# PHP development
sudo apt-get -y install php5
# PHP extensions
sudo apt-get -y install php5-xcache

# Python development
sudo apt-get -y install python-setuptools python-pip

# Python common extensions
sudo apt-get -y install python-mysqldb python-docutils

# Django development
sudo apt-get -y install python-django 

#
# DEBUGGING
#
# MC is crashing a lot
sudo apt-get -y install mc-dbg
# Krusader is crashing a lot
sudo apt-get -y install krusader-dbg

#
# FIXES
#
# Linux kernel support for HFS+ file system used by Apple Computer for their Mac OS (write access).
# Homepage: http://www.opensource.apple.com/darwinsource/10.4/
sudo apt-cache -y show hfsprogs


# Fix for dnsmasq conflict
#   <warn> dnsmasq not available on the bus, can't update servers.
#   <error> [1373987121.101145] [nm-dns-dnsmasq.c:402] update(): dnsmasq owner not found on bus: Could not get owner of name 'org.freedesktop.NetworkManager.dnsmasq': no such name
#   <warn> DNS: plugin dnsmasq update failed
# 
# See: http://askubuntu.com/questions/262301/is-dnsmasq-not-loading-because-of-a-network-manager-conflict
sudo apt-get -y install dnsmasq-base

#
# OTHER TOOLS
#
# Fun tools
sudo apt-get -y install beep sl

#
# CONFIGURATION CHANGES
#
# Alt+SysRq has been disabled since Ubuntu 10.10 maverick, so re-activating it.
# It is useful for kernel debugging and troubleshooting kernel crashes.
# See: http://en.wikipedia.org/wiki/Magic_SysRq_key
echo 1 | sudo tee /proc/sys/kernel/sysrq
sudo sed -i'.bak' "s/kernel.sysrq.=.[0-9]*/kernel.sysrq = 1/" /etc/sysctl.d/10-magic-sysrq.conf
# echo "kernel.sysrq=1" | sudo tee /etc/sysctl.conf # Alternative way


