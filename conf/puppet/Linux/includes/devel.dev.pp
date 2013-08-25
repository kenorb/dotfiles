#
# Puppet recipe to install common development tools
#
# Author: kenorb

#
# DEVELOPMENT
#
# Common Linux development tools
package { 'autoconf': }
package { 'automake': }
package { 'libtool': }
#
# Common Linux tools
package { 'iotop': }
package { 'htop': }

