#
# quick puppet recipe to install LAMP stack.
#

# development packages
$packages_dev = [ 'git', 'zip', 'unzip' ]
package { $packages_dev : 
  ensure => installed,
}

# sendmail
package { 'sendmail' :
  ensure => installed,
}

service { 'sendmail' :
  ensure => running,
  require => Package['sendmail']
}

# memcached
package { 'memcached' :
  ensure => installed,
}

service { 'memcached' :
  ensure => running,
  require => Package['memcached'],
}

# apache
package { 'apache2' :
  ensure => installed,
}

service { 'apache2' :
  ensure => running,
  require => Package['apache2'],
}

exec { "a2enmod-rewrite":
   creates => "/etc/apache2/mods-enabled/rewrite.load",
   command => "/usr/sbin/a2enmod rewrite",
   require => Package["apache2"],
   notify  => Service["apache2"],
}

# mysql
package { 'mysql-server' :
 ensure => installed,
}

service { 'mysql' :
  ensure => running,
  require => Package['mysql-server'],
}

# php packages
$packages_php = [ 'libapache2-mod-php5', 'php5', 'php5-cli', 'php5-cgi', 'php5-common', 'php5-curl', 'php5-gd', 'php5-mysql', 'php5-pspell', 'php5-imagick', 'php5-mcrypt', 'php5-memcache', 'php5-memcached', 'php-apc', 'php-pear', 'php5-tidy', 'php5-odbc',  ]

package { $packages_php :
  ensure => installed,
  require => Package['apache2'],
  notify => Service['apache2']
}
