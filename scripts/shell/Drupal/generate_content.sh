#!/bin/bash

# Shell script to generate random content via drush.
#
# Note:
#   devel_generate (Devel) module is required.

CWD=$(dirname `readlink -f $0 || realpath $0`)  # Get the current working directory (Linux || Mac support)
DOCROOT="public_html"
APACHE_USER=$(ps axho user,comm|grep -E "httpd|apache"|uniq|grep -v "root"|awk 'END {if ($1) print $1}')
SUDO="sudo -u $APACHE_USER"
DRUSH="$SUDO drush -y -r $CWD/../$DOCROOT"

set -o xtrace
$DRUSH en devel_generate
$DRUSH generate-terms tags 10
$DRUSH generate-content --types=page 10
# $DRUSH generate-content --types=advert --skip-fields=field_advert_ref 10  # Example with skipping fields
$DRUSH search-api-index # Index pages via Search API
set -o xtrace -
