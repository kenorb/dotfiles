#!/bin/sh
#
# Make the backup of Atlassian JIRA and Confluence files
#
# @author Rafal Wieczorek <kenorb>
#
# Usage:
#   ./dl_atlassian_files.sh URL (username) (password)
#
# Note:
#   Once cookie file has been generated (cookies.txt),
#   you don't have to specify the user and password again.
#   Remove cookies.txt file to start from scratch.
#

URL="$1"
USER="$2"
PASS="$3"

DATE="`date '+%Y-%m-%d'`"
COOKIE="cookies.txt"
ATT_DIR="jira-attachments"

if [ ! -n "$URL" ]; then
  echo "Usage:"
  echo "$0 URL (username) (password)"
  exit 1
fi

# Perform the Log in action (if cookies.txt does not exists yet)
if [ ! -f "cookies.txt" ]; then 
  wget -O- --keep-session-cookies --save-cookies $COOKIE --post-data -U Mozilla "username=$USER&password=$PASS" $URL/login | grep -q "Log Out" \
    && echo "Logged successfully." \
    || (echo "Wrong credentials."; rm -v $COOKIE)
fi

# Download all JIRA tickets on one page
wget -O SearchRequest-$DATE.html -nc -c --load-cookies $COOKIE -U Mozilla $URL/sr/jira.issueviews:searchrequest-fullcontent/temp/SearchRequest.html
wget -O SearchRequest-$DATE.xml -nc -c --load-cookies $COOKIE -U Mozilla $URL/sr/jira.issueviews:searchrequest-xml/temp/SearchRequest.xml
wget -O SearchRequest-$DATE.doc -nc -c --load-cookies $COOKIE -U Mozilla $URL/sr/jira.issueviews:searchrequest-word/temp/SearchRequest.doc
wget -O SearchRequest-$DATE.xls -nc -c --load-cookies $COOKIE -U Mozilla $URL/sr/jira.issueviews:searchrequest-excel-all-fields/temp/SearchRequest.xls

# Parse and download all JIRA attachments
grep -o '<attachment id="[^"]*" name="[^"]*"' SearchRequest-$DATE.xml | cut -d'"' -f2,4 | sed 's@"@/@' \
       | xargs -L1 -I% wget -c -nc -P $ATT_DIR --load-cookies $COOKIE $URL/secure/attachment/%

