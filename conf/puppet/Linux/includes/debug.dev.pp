#
# Puppet recipe to install tools for debugging
#
# Author: kenorb

#
# DEBUGGING
#
# Debugging tools
package { "strace": }
# MC is crashing a lot
package { "mc-dbg": }
# Krusader is crashing a lot
package { "krusader-dbg": }


