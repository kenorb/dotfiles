#!/bin/bash
#
# Downloader of online version of Metro UK newspapper

# Notes:
#  - first issue: 2008/07/25
#
# Author: Rafal Wieczorek <kenorb>
# 

for year in {2008..2013}; do
  for month in 0{1..9} {10..12}; do
    for day in 0{1..9} {10..31}; do
      for page in {1..80}; do
        if [ $year -eq 2008 ] && [ $month -eq 01 ] && [ $day -eq 01 ]; then
          # If beginning of 2008, jump to the first released issue
          day=25
          month=07
        fi
        # Download thumbnail and full SWF page for every page, otherwise go to the next issue
        wget -c -x -UMozilla --tries=3 -nc http://e-edition.metro.co.uk/$year/$month/$day/pages/$page/thumb.jpg \
        && wget -c -x -UMozilla --tries=3 -nc http://e-edition.metro.co.uk/$year/$month/$day/pages/$page/page.swf \
        || break
      done
    done
  done
done
