#!/bin/sh
#
# Script to run Drupal Simpletests
#
# @see http://drupal.org/node/1817744
#
# @file run_tests.sh
#
# @author Rafal Wieczorek <kenorb>
#

# Variables
DEBUG="strace -fe write -s100 "
FILTER="sed 's@\\\\[0-9]*@@g' | cut -d' ' -f2-"

# Sudo requirement
echo Checking the environment...
sudo uname -a

# Check the arguments
if [ "$1" = "debug" ]; then
  PREFIX="$DEBUG"
  which strace || sudo apt-get install strace
else
  echo "Hint: you can use: '$0 debug' command to debug tests using strace."
fi
if [ -n "$2" ]; then
  TESTS=$2
else
  echo "Hint: you can use: '$0 run testMyTest' command to run a specific test."
  TESTS="--all"
fi

# Detect Drupal root
DRUPAL_ROOT="`drush status "Drupal root" | awk '{print $NF}' | head -n1`"
FILES_DIR="files"

# Change it to your proper apache user
APACHE_USER="`stat -c %U $DRUPAL_ROOT/$FILES_DIR`"

# Trying to detect last used vhost based on the latest watchdog entry
VHOST="`drush sqlq "SELECT location FROM {watchdog} ORDER BY wid DESC LIMIT 1" | tail -n1 | cut -d/ -f1-3`"

# drush command
DRUSH="drush -y -l $VHOST"

echo "Drupal root:  " $DRUPAL_ROOT
echo "Files dir:    " $FILES_DIR
echo "Apache user:  " $APACHE_USER
echo "Virtual host: " $VHOST
echo "Drush cmd:    " $DRUSH
echo "PHP:          " $(php -v)

echo Running tests...
set -o xtrace
drush -y en simpletest simpletest_clone
chdir "$DRUPAL_ROOT"
sudo -u $APACHE_USER $PREFIX $DRUSH test-run $TESTS --dirty
set -o xtrace -

echo "Cleaning temporary tables and files..."
sudo -u $APACHE_USER $PREFIX $DRUSH test-clean
echo "$0 done."

