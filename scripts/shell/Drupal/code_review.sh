#!/bin/sh
DRUSH="drush -r ../trunk"
MODULES="my_module"

echo "Checking code..."

set -o xtrace

$DRUSH coder-review no-empty critical upgrade7x $MODULES &
$DRUSH coder-review no-empty critical comment $MODULES &
# $DRUSH coder-review no-empty critical i18n $MODULES &
$DRUSH coder-review no-empty critical security $MODULES &
$DRUSH coder-review no-empty critical sql $MODULES &
$DRUSH coder-review no-empty critical style $MODULES &
# $DRUSH coder-review no-empty warning upgrade7x comment i18n security sql style  $MODULES | head -n20

set -o xtrace -

echo $0 "done."

