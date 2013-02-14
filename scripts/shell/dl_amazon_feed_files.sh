#!/bin/bash
#
# Download all files from specific Amazon feed
#
# @author
#   Rafal Wieczorek <kenorb>
#
# Usage:
#  ./dl_amazon_feed_files.sh http://example.s3.amazonaws.com/
# Note: Don't forget about slash at the end
#

wget -q -O- "$1" | grep -o '<Key>[^<]*' | grep -o "[^>]*$" | xargs -I% -L1 wget -c "$1%"

