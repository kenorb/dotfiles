#
# puppet recipe to install Ubuntu LAMP environment.
#
# Author: kenorb

# Dependencies:
#   sudo apt-get -y install puppet
#   sudo puppet module install puppetlabs/apt
# Usage:
#   sudo puppet apply ubuntu.dev.pp

# global package parameter
Package { ensure => "installed" }

import 'includes/*.pp'

