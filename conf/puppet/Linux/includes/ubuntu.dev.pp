#
# Puppet recipe to install debugging environment
#
# Author: kenorb

# Fix for dnsmasq conflict
#   <warn> dnsmasq not available on the bus, can't update servers.
#   <error> [1373987121.101145] [nm-dns-dnsmasq.c:402] update(): dnsmasq owner not found on bus: Could not get owner of name 'org.freedesktop.NetworkManager.dnsmasq': no such name
#   <warn> DNS: plugin dnsmasq update failed
# 
# See: http://askubuntu.com/questions/262301/is-dnsmasq-not-loading-because-of-a-network-manager-conflict
package { "dnsmasq-base": }

