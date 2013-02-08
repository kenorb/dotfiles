#
# Simple script to convert tabs to spaces in the specific codebase
#
# @author Rafal Wieczorek <kenorb>
#

CUSTOM_DIR="../trunk/sites/all/modules/custom"

set -o xtrace

# Find all tabs and replace them with spaces
find $CUSTOM_DIR -name \*.module -or -name \*.inc -or -name \*.php -exec grep -l "^	" {} \; | xargs -L1 sed -i'.bak' "s/	/  /g"

# Find all spaces at the end of the lines
find $CUSTOM_DIR -name \*.module -or -name \*.inc -or -name \*.php -exec grep -l " $" {} \; | xargs -L1 sed -i'.bak' "s/ $//g"

# Review the differences
git diff $CUSTOM_DIR

