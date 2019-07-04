# ~/.bash_functions
# Define Bash functions.
# Invoked by .bash_profile file.

# Includes other function definitions.
if [ -f ~/.bash_functions_mysql ]; then
  . ~/.bash_functions_mysql
fi

# FUNCTIONS

# Realpath to provide absolute path with OSX
# See: http://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx
realpath () {
  [[ "$1" = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}


# Change dir recursively via find.
# Note: It's basically the same as: cd **/dir when globstar is enabled.
# Usage: cdf (dir)
cdf() {
  pushd "$(find . -name "$1")"
}

# Find files/dirs by name recursively.
# Usage: ff (file)
f() {
  find . -name "*$1*"
}

# Find file by exact name recursively.
# Usage: ff (file)
ff() {
  find . -name "$1"
}

# Search for pattern in UTF-16 files with Ruby.
# Usage: grep16 PATTERN file.txt
grep16() {
  ruby -e "puts File.open('$2', mode:'rb:BOM|UTF-16LE').readlines.grep(Regexp.new '$1'.encode(Encoding::UTF_16LE))";
}

# Find recursively and edit the file in Vim.
# Note: It's basically the same as: vim **/file when globstar is enabled.
# Usage: ff (file)
vimf() {
  vim "$(find . -name "*$1*")"
}

# Allows you to search for any text in any file recursively.
# Usage: ft "my string" *.php
ft() {
  find . -name "$2" -exec grep -il "$1" {} \;
}

# Find duplicate files.
# Usage: dups (dir)
dups() {
  fdupes -v && fdupes -rS1 "$1" | sed '$!N;s/\n/ /' | sort -n
}

# Search for command in history.
# Usage: hs (string)
hs() {
  history | grep "$1"
}

# Trace mysqld for queries
# Usage: dmysql
dmysql() {
  sudo dtruss -t read -fn mysqld 2>&1 | grep -Eo '[A-Z]{4}[^"]+'
}

# Trace apache
# Usage: dapache
dapache() {
  sudo dtruss -fn httpd
}

# Trace apache files
# Usage: dapache-files
dapache-files() {
  sudo dtruss -t open -fn httpd 2>&1 | grep -o '".*"' | grep -o '[^"].*\\'
}

# Strip trailing whitespaces.
# Usage: trim *.*
# See: http://stackoverflow.com/q/149057/55075
#trim() {
#  ex +'bufdo!%s/\s\+$//e' -cxa $*
#}

# Convert tabs to spaces.
# Usage: retab *.*
# See: http://stackoverflow.com/q/11094383/55075
#retab() {
#  ex +'set ts=2' +'bufdo retab' -cxa $*
#}

# Archive the page in Wayback Machine.
# Usage: archive http://example.com/
archive() {
  for url in $*; do curl -vs http://web.archive.org/save/$url | tail; done
}

# Extract most know archives
# Usage: extract (file)
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Uncompress zlib data (e.g. git objects)
# Usage: deflate (file)
deflate() {
  printf "\x1f\x8b\x08\x00\x00\x00\x00\x00"  | cat -- - $1 | gunzip
}

# Convert svn branches and tags into git.
# Usage: svn2git
# See: http://stackoverflow.com/q/2244252/55075
svn2git() {
  git svn fetch --all # Fetch all remote branches that have not been fetched yet.
  git for-each-ref --format="%(refname:short) %(objectname)" refs/remotes/tags \
  | while read BRANCH REF
    do
          TAG_NAME=${BRANCH#*/}
          BODY="$(git log -1 --format=format:%B $REF)"
          echo "ref=$REF parent=$(git rev-parse $REF^) tagname=$TAG_NAME body=$BODY" >&2
          git tag -a -m "$BODY" $TAG_NAME $REF^  && \ # Create git tag from tag branch.
          git branch -r -d $BRANCH # Delete tag branch.
    done
}

# Convert video to gif file.
# Usage: video2gif video_file (scale) (fps)
video2gif() {
  ffmpeg -y -i "${1}" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen "${1}.png"
  ffmpeg -i "${1}" -i "${1}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${1}".gif
  rm "${1}.png"
}
#
# Compare two binary files.
# Usage: diffhex file1 file2
# See: http://superuser.com/a/968863/87805
diffhex() {
  diff -y -W200 <(xxd -l1000 "$1") <(xxd -l1000 "$2") | colordiff
}

# Compare two binary files.
# Usage: open-rdp ip-address
open-rdp() {
  open rdp://full%20address=s:$*
}

# GitHub clone all user repositories.
# Usage: gh-clone-user (user)
gh-clone-user() {
  curl -sL "https://api.github.com/users/$1/repos?per_page=1000" | jq -r '.[]|.clone_url' | xargs -L1 git clone --recurse-submodules
}

# GitHub clone all user private repositories.
# Usage: gh-clone-user-priv (user)
gh-clone-user-priv() {
  type jq > /dev/null || return
  [ -z "$GITHUB_API_TOKEN" ] && { echo "Error: Define GITHUB_API_TOKEN."; return; }
  curl -sL "https://api.github.com/users/$1/repos?access_token=$GITHUB_API_TOKEN&per_page=1000&type=private" | jq -r '.[]|.clone_url' | xargs -L1 git clone --recurse-submodules
}
