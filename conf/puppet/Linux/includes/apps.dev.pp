#
# Puppet recipe to install common applications
#
# Author: kenorb

#
# COMMON TOOLS
#
# Commonly used command lines
package { 'sudo': }
package { 'bash': }
package { 'realpath': }
# Commonly used tools
package { 'screen': }
package { 'mc': }
# For: sfill - secure free disk and inode space wiper
package { 'secure-delete': }
# Web tools
package { 'wget': }
package { 'links': }
package { 'lynx': }
# Media tools
package { 'youtube-dl': }

