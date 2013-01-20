#!/bin/sh
DRUSH="drush -r ../trunk"

echo "Updating Drupal core and contrib projects to latest recommended releases..."

set -o xtrace
$DRUSH -y pm-updatecode
set -o xtrace -

echo $0 "done."

