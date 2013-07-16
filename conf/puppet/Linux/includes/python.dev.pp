#
# Puppet recipe to install Python development environment.
#
# Author: kenorb

#
# PROGRAMMING
#
# Python development
package { 'python': }
package { 'python-setuptools': }
package { 'python-pip': }

# Python common extensions
package { 'python-mysqldb': }
package { 'python-docutils': }

# Django development
package { 'python-django': }

