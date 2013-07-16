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

#
# DEVELOPMENT
#
# Common Linux development tools
sudo apt-get -y install autoconf libtool automake

#
# PROGRAMMING
#
# Python development
sudo apt-get -y install python-setuptools python-pip

# Python common extensions
sudo apt-get -y install python-mysqldb python-docutils

# Django development
sudo apt-get -y install python-django 

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
# OTHER
#
# Fun tools
sudo apt-get -y install beep sl

