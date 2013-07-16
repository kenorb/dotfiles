# /etc/puppet/modules/sysctl/manifests/init.pp
class sysctl {
   file { "sysctl_conf":
      name => $operatingsystem ? {
        default => "/etc/sysctl.conf",
      },
   }

   exec { "sysctl -p":
      alias => "sysctl",
      refreshonly => true,
      subscribe => File["sysctl_conf"],
   }
}

# /etc/puppet/modules/sysctl/manifests/conf.pp
define sysctl::conf ( $value ) {

  include sysctl

  # $title contains the title of each instance of this defined type

  # guid of this entry
  $key = $title

  $context = "/files/etc/sysctl.conf"

   augeas { "sysctl_conf/$key":
     context => "$context",
     onlyif  => "get $key != '$value'",
     changes => "set $key '$value'",
     notify  => Exec["sysctl"],
   }

} 

