#!/bin/sh -x
#
# Make the backup of Atlassian JIRA and Confluence files
#
# @author Rafal Wieczorek <kenorb>
#
# Usage:
#   ./dl_atlassian_confluence.sh URL (username) (password)
#
# Note:
#   Once cookie file has been generated (cookies.txt),
#   you don't have to specify the user and password again.
#   Remove cookies.txt file to start from scratch.
#
# Known issues:
#   There could be some problem on Mountain Lion OSX (Perl Regex Removed From Grep in Mountain Lion).
#   Workaround: use pcregrep instead
#   See: http://news.ycombinator.com/item?id=4588304
#

# Get PDF version of page (set false to disable it)
GET_PDF="true"
# Get Attachments (set false to disable it)
GET_ATTS="true"
# Get all 8 levels (set false to disable that level and above)
LEVEL1="true"
LEVEL2="true"
LEVEL3="true"
LEVEL4="true"
LEVEL5="true"
LEVEL6="true"
LEVEL7="true"
LEVEL8="true"
# Cookie file to use by wget
COOKIE="cookies.txt"
# Shared directory to download the attachments from XML Feed
ATT_DIR="confluence-attachments"
# Max items to download from XML Feed
MAX="10000"
# Specify the delay between each successful download (in sec)
DELAY=2
# Specify the User Agent for wget
BROWSER="Mozilla/4.0"

DATE="`date '+%Y-%m-%d'`"

URL="$1"
USER="$2"
PASS="$3"

if [ ! -n "$URL" ]; then
  echo "Usage:"
  echo "$0 URL (username) (password)"
  exit 1
fi

# Perform the Log in action (if cookies.txt does not exists yet)
if [ ! -f "cookies.txt" ]; then 
  wget -O- --keep-session-cookies --save-cookies $COOKIE --post-data -U $BROWSER "username=$USER&password=$PASS" $URL/login | grep -q "Log Out" \
    && echo "Logged successfully." \
    || (echo "Wrong credentials."; rm -v $COOKIE)
fi

# Download feed of all Confluence attachments
wget -O Confluence-All-$DATE.xml          -nc -c --load-cookies $COOKIE -U $BROWSER "$URL/wiki/spaces/createrssfeed.action?types=page&types=comment&types=blogpost&types=mail&types=attachment&maxResults=$MAX"
wget -O Confluence-Attachments-$DATE.xml  -nc -c --load-cookies $COOKIE -U $BROWSER "$URL/wiki/spaces/createrssfeed.action?types=attachment&maxResults=$MAX"
#wget -O Confluence-Pages-$DATE.xml        -nc -c --load-cookies $COOKIE -U $BROWSER "$URL/wiki/spaces/createrssfeed.action?types=page&maxResults=$MAX"
#wget -O Confluence-Comments-$DATE.xml     -nc -c --load-cookies $COOKIE -U $BROWSER "$URL/wiki/spaces/createrssfeed.action?types=comment&maxResults=$MAX"
#wget -O Confluence-Blogs-$DATE.xml        -nc -c --load-cookies $COOKIE -U $BROWSER "$URL/wiki/spaces/createrssfeed.action?types=blogpost&maxResults=$MAX"
#wget -O Confluence-Mails-$DATE.xml        -nc -c --load-cookies $COOKIE -U $BROWSER "$URL/wiki/spaces/createrssfeed.action?types=mail&maxResults=$MAX"

# Parse and download all Confluence attachments from Feed
grep -o 'wiki/download/attachments/[^?"]*' Confluence-Attachments-$DATE.xml | uniq \
  | xargs -L1 -I% wget -c -nc -P $ATT_DIR --load-cookies $COOKIE $URL/%

# Perl Regex Removed From Grep in Mountain Lion, use pcregrep instead (See: http://news.ycombinator.com/item?id=4588304, http://www.dirtdon.com/?p=1452)
#PROJECTS="`grep -Po "wiki/display/\K(MP)" Confluence-All-$DATE.xml | uniq`"
PROJECTS="`pcregrep -o "wiki/display/\K(MP)" Confluence-All-$DATE.xml | uniq`"
# Download all pages for each project into html file hierarchically
for project in $PROJECTS; do
  echo "Project: $project"
  wget -O "Confluence-wiki-$project-$DATE.html" -nc -c --load-cookies $COOKIE -U $BROWSER "$URL/wiki/display/$project"

  filename="Confluence-wiki-$project-$DATE.html"
  topdir="$project"
  wget_args="-c -nc --load-cookies $COOKIE -U $BROWSER --content-disposition --tries=2"
  # read values from stdin pipe (http://stackoverflow.com/questions/2746553/bash-script-read-values-from-stdin-pipe)
  `$LEVEL1` && grep "icon icon-page" "$filename" | sed -nE 's@^.*/(wiki/[^"]+)[^>]>([^<]+).+@\1 \2@p' |
    {
      while read path name; do
        name=$(echo $name | sed s#/#:#g) # Escaping parentheses not necesary: | sed -E 's#([()])#\\\1#g'
        dir="$topdir/$name"
        filename="$dir/$name"
        mkdir -vp "$dir"
        wget $wget_args -P "$dir" -O "$filename.html" "$URL/$path" && sleep $DELAY
        # Download PDF page
        pdflink="$URL$(grep -Eo '[^"]+pdfpageexport.action[^"]+' "$filename.html")"
        pageid=$(echo $pdflink | grep -Eo "[0-9]+$")
        $($GET_PDF) && wget $wget_args -P "$dir" -O "$filename.pdf" $pdflink && sleep $DELAY
        # Download html page with attachments
        attlink="$URL$(grep -Eo '[^"]+viewpageattachments.action[^"]+' "$filename.html" | head -n1)"
        $($GET_ATTS) && wget $wget_args -P "$dir" -O "$dir/Attachments.html" $attlink
        # Download page attachments
        $($GET_ATTS) && grep -Eo '[^"]+download/attachments[^"?]+' "$dir/Attachments.html" | uniq | 
          xargs -L1 -I% wget $wget_args -P "$dir" "$URL%"

        # 2nd level
        `$LEVEL2` && grep "icon icon-page" "$filename.html" | sed -nE 's@^.*/(wiki/[^"]+)[^>]>([^<]+).+@\1 \2@p' |
          {
            while read path2 name2; do
              name2=$(echo $name2 | sed s#/#:#g) # Escaping parentheses not necesary: | sed -E 's#([()])#\\\1#g'
              dir2="$dir/$name2"
              filename="$dir2/$name2"
              mkdir -vp "$dir2"
              wget $wget_args -P "$dir2" -O "$filename.html" "$URL/$path2" && sleep $DELAY
              # Download PDF page
              pdflink="$URL$(grep -Eo '[^"]+pdfpageexport.action[^"]+' "$filename.html")"
              pageid=$(echo $pdflink | grep -Eo "[0-9]+$")
              $($GET_PDF) && wget $wget_args -P "$dir2" -O "$filename.pdf" $pdflink && sleep $DELAY
              # Download html page with attachments
              attlink="$URL$(grep -Eo '[^"]+viewpageattachments.action[^"]+' "$filename.html" | head -n1)"
              $($GET_ATTS) && wget $wget_args -P "$dir2" -O "$dir2/Attachments.html" $attlink
              # Download page attachments
              $($GET_ATTS) && grep -Eo '[^"]+download/attachments[^"?]+' "$dir2/Attachments.html" | uniq | 
                xargs -L1 -I% wget $wget_args -P "$dir2" "$URL%"
                

              # 3rd level
              `$LEVEL3` && grep "icon icon-page" "$filename.html" | sed -nE 's@^.*/(wiki/[^"]+)[^>]>([^<]+).+@\1 \2@p' |
                {
                  while read path3 name3; do
                    name3=$(echo $name3 | sed s#/#:#g) # Escaping parentheses not necesary: | sed -E 's#([()])#\\\1#g'
                    dir3="$dir2/$name3"
                    filename="$dir3/$name3"
                    mkdir -vp "$dir3"
                    wget $wget_args -P "$dir3" -O "$filename.html" "$URL/$path3" && sleep $DELAY
                    # Download PDF page
                    pdflink="$URL$(grep -Eo '[^"]+pdfpageexport.action[^"]+' "$filename.html")"
                    pageid=$(echo $pdflink | grep -Eo "[0-9]+$")
                    $($GET_PDF) && wget $wget_args -P "$dir3" -O "$filename.pdf" $pdflink && sleep $DELAY
                    # Download html page with attachments
                    attlink="$URL$(grep -Eo '[^"]+viewpageattachments.action[^"]+' "$filename.html" | head -n1)"
                    $($GET_ATTS) && wget $wget_args -P "$dir3" -O "$dir3/Attachments.html" $attlink

                    # 4th level
                    `$LEVEL4` && grep "icon icon-page" "$filename.html" | sed -nE 's@^.*/(wiki/[^"]+)[^>]>([^<]+).+@\1 \2@p' |
                      {
                        while read path4 name4; do
                          name4=$(echo $name4 | sed s#/#:#g) # Escaping parentheses not necesary: | sed -E 's#([()])#\\\1#g'
                          dir4="$dir3/$name4"
                          filename="$dir4/$name4"
                          mkdir -vp "$dir4"
                          wget $wget_args -P "$dir4" -O "$filename.html" "$URL/$path4" && sleep $DELAY
                          # Download PDF page
                          pdflink="$URL$(grep -Eo '[^"]+pdfpageexport.action[^"]+' "$filename.html")"
                          pageid=$(echo $pdflink | grep -Eo "[0-9]+$")
                          $($GET_PDF) && wget $wget_args -P "$dir4" -O "$filename.pdf" $pdflink && sleep $DELAY
                          # Download html page with attachments
                          attlink="$URL$(grep -Eo '[^"]+viewpageattachments.action[^"]+' "$filename.html" | head -n1)"
                          $($GET_ATTS) && wget $wget_args -P "$dir4" -O "$dir4/Attachments.html" $attlink

                          # 5th level
                          `$LEVEL5` && grep "icon icon-page" "$filename.html" | sed -nE 's@^.*/(wiki/[^"]+)[^>]>([^<]+).+@\1 \2@p' |
                            {
                              while read path5 name5; do
                                name5=$(echo $name5 | sed s#/#:#g) # Escaping parentheses not necesary: | sed -E 's#([()])#\\\1#g'
                                dir5="$dir4/$name5"
                                filename="$dir5/$name5"
                                mkdir -vp "$dir5"
                                wget $wget_args -P "$dir5" -O "$filename.html" "$URL/$path5" && sleep $DELAY
                                # Download PDF page
                                pdflink="$URL$(grep -Eo '[^"]+pdfpageexport.action[^"]+' "$filename.html")"
                                pageid=$(echo $pdflink | grep -Eo "[0-9]+$")
                                $($GET_PDF) && wget $wget_args -P "$dir5" -O "$filename.pdf" $pdflink && sleep $DELAY
                                # Download html page with attachments
                                attlink="$URL$(grep -Eo '[^"]+viewpageattachments.action[^"]+' "$filename.html" | head -n1)"
                                $($GET_ATTS) && wget $wget_args -P "$dir5" -O "$dir5/Attachments.html" $attlink

                                # 6th level
                                `$LEVEL6` && grep "icon icon-page" "$filename.html" | sed -nE 's@^.*/(wiki/[^"]+)[^>]>([^<]+).+@\1 \2@p' |
                                  {
                                    while read path6 name6; do
                                      name6=$(echo $name6 | sed s#/#:#g) # Escaping parentheses not necesary: | sed -E 's#([()])#\\\1#g'
                                      dir6="$dir5/$name6"
                                      filename="$dir6/$name6"
                                      mkdir -vp "$dir6"
                                      wget $wget_args -P "$dir6" -O "$filename.html" "$URL/$path6" && sleep $DELAY

                                      # Download PDF page
                                      pdflink="$URL$(grep -Eo '[^"]+pdfpageexport.action[^"]+' "$filename.html")"
                                      pageid=$(echo $pdflink | grep -Eo "[0-9]+$")
                                      $($GET_PDF) && wget $wget_args -P "$dir6" -O "$filename.pdf" $pdflink && sleep $DELAY
                                      # Download html page with attachments
                                      attlink="$URL$(grep -Eo '[^"]+viewpageattachments.action[^"]+' "$filename.html" | head -n1)"
                                      $($GET_ATTS) && wget $wget_args -P "$dir6" -O "$dir6/Attachments.html" $attlink

                                      # 7th level
                                      `$LEVEL7` && grep "icon icon-page" "$filename.html" | sed -nE 's@^.*/(wiki/[^"]+)[^>]>([^<]+).+@\1 \2@p' |
                                        {
                                          while read path7 name7; do
                                            name7=$(echo $name7 | sed s#/#:#g) # Escaping parentheses not necesary: | sed -E 's#([()])#\\\1#g'
                                            dir7="$dir6/$name7"
                                            filename="$dir7/$name7"
                                            mkdir -vp "$dir7"
                                            wget $wget_args -P "$dir7" -O "$filename.html" "$URL/$path7" && sleep $DELAY

                                            # Download PDF page
                                            pdflink="$URL$(grep -Eo '[^"]+pdfpageexport.action[^"]+' "$filename.html")"
                                            pageid=$(echo $pdflink | grep -Eo "[0-9]+$")
                                            $($GET_PDF) && wget $wget_args -P "$dir7" -O "$filename.pdf" $pdflink && sleep $DELAY
                                            # Download html page with attachments
                                            attlink="$URL$(grep -Eo '[^"]+viewpageattachments.action[^"]+' "$filename.html" | head -n1)"
                                            $($GET_ATTS) && wget $wget_args -P "$dir7" -O "$dir7/Attachments.html" $attlink

                                            # 8th level (add if needed)

                                          done
                                        }

                                    done
                                  }

                              done
                            }

                        done
                      }

                  done
                }

            done
          }

      done
    }
done

