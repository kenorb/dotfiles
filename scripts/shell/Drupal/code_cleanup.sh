#!/bin/sh
#
# @author Rafal Wieczorek <kenorb>
#

CUSTOM_DIR="../trunk/sites/all/modules/custom"
IGNORE_LIST="-e features -e strongarm -e field_group"

# Use LANGUAGE_NONE instead of 'und' key
sed -i'.bak' "s/'und'/LANGUAGE_NONE/g" `find $CUSTOM_DIR -type f -name \*.inc -or -name \*.php -or -name \*.module | grep -v $IGNORE_LIST`

# Use TRUE instead of true
sed -i'.bak' "s/ true/ TRUE/g" `find $CUSTOM_DIR -type f -name \*.inc -or -name \*.php -or -name \*.module | grep -v $IGNORE_LIST`
sed -i'.bak' "s/=true/=TRUE/g" `find $CUSTOM_DIR -type f -name \*.inc -or -name \*.php -or -name \*.module | grep -v $IGNORE_LIST`

# Use FALSE instead of false
sed -i'.bak' "s/ false/ FALSE/g" `find $CUSTOM_DIR -type f -name \*.inc -or -name \*.php -or -name \*.module | grep -v $IGNORE_LIST`
sed -i'.bak' "s/=false/=FALSE/g" `find $CUSTOM_DIR -type f -name \*.inc -or -name \*.php -or -name \*.module | grep -v $IGNORE_LIST`

# Use NULL instead of null
sed -i'.bak' "s/ null/ NULL/g" `find $CUSTOM_DIR -type f -name \*.inc -or -name \*.php -or -name \*.module | grep -v $IGNORE_LIST`
sed -i'.bak' "s/=null/=NULL/g" `find $CUSTOM_DIR -type f -name \*.inc -or -name \*.php -or -name \*.module | grep -v $IGNORE_LIST`

echo Done. Cleaning...
find $CUSTOM_DIR -type f -name \*.bak -exec rm -v {} \;

# Show the changes
git diff
