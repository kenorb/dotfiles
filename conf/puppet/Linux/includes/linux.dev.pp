#
# Puppet recipe to configure Linux environment
#
# Author: kenorb

# Augeas is a configuration editing tool. It parses configuration files in their native formats and transforms them into a tree.
package { "augeas-tools": }

#
# FIXES
#
# Linux kernel support for HFS+ file system used by Apple Computer for their Mac OS (write access).
# Homepage: http://www.opensource.apple.com/darwinsource/10.4/
package { "hfsprogs": }

