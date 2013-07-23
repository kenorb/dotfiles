#
# Puppet recipe to install common applications
#
# Author: kenorb

#
# COMMON TOOLS
#

#
# Admin and shell tools
#
package { 'sudo': }
package { 'bash': }
package { 'realpath': }
package { 'screen': }

#
# Scripting tools
#
package { 'parallel': }
package { 'htmldoc': }

#
# File managements
#
package { 'mc': }
# For: sfill - secure free disk and inode space wiper
package { 'secure-delete': }

#
# Web tools
#
package { 'wget': }
package { 'links': }
package { 'lynx': }
# Google CL - GoogleCL is the google on command line.
# GitHub: https://github.com/vinitcool76/googlecl
package { 'googlecl': }
# Surfraw (Shell Users' Revolutionary Front Rage Against the Web) - command-line shell program for interfacing with a number of web-based search engines
# Wiki: http://en.wikipedia.org/wiki/Surfraw
package { 'surfraw': }

#
# Media tools
#
# GitHub: https://github.com/rg3/youtube-dl
package { 'youtube-dl': }

#
# Print tools
# 
package { 'cups-pdf': }
