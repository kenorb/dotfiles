#
# Puppet recipe to install common applications
#
# Author: kenorb

#
# COMMON TOOLS
#

# Admin and shell tools
package { 'sudo': }
package { 'bash': }
package { 'realpath': }
package { 'screen': }

# Scripting tools
package { 'parallel': }
package { 'htmldoc': }

# File managements
package { 'mc': }
# For: sfill - secure free disk and inode space wiper
package { 'secure-delete': }

# Web tools
package { 'wget': }
package { 'links': }
package { 'lynx': }

# Media tools
package { 'youtube-dl': }

# Print tools
package { 'cups-pdf': }
