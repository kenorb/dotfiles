# .bash_profile

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
echo $(basename $BASH_SOURCE) loaded.

# Load user profile file
if [ -f ~/.profile ]; then
  . ~/.profile
fi

# FUNCTIONS

# Realpath to provide absolute path with OSX
# See: http://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx
realpath () {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}


# Change dir via find
# Usage: cdf (dir)
cdf() {
  pushd $(find . -name $1)
}

# Find file
# Usage: ff (file)
ff() {
  find . -name $1
}

# Vim file via find
# Usage: ff (file)
vimf() {
  vim $(find . -name $1)
}

# Allows you to search for any text in any file.
# Usage: ft "my string" *.php
ft() {
  find . -name "$2" -exec grep -il "$1" {} \;
}

# Find duplicate files
# Usage: dups (dir)
dups() {
  fdupes -v && fdupes -rS1 $1 | sed '$!N;s/\n/ /' | sort -n
}

# Find command in history
# Usage: ff (file)
h() {
  history | grep $1
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
deflate () {
  printf "\x1f\x8b\x08\x00\x00\x00\x00\x00"  | cat -- - $1 | gunzip
}

# Convert svn branches and tags into git.
# Usage: svn2git
# See: http://stackoverflow.com/q/2244252/55075
svn2git () {
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

# GLOBAL VARIABLES #
# Set architecture flags for x64
export ARCHFLAGS="-arch x86_64"
export LANG=C LC_CTYPE=C # Fixes for sed, see: http://www.delorie.com/gnu/docs/gawk/gawk_149.html, http://stackoverflow.com/q/19242275/55075

# added by Anaconda 1.5.1 installer
# export PATH="/Users/$USER/anaconda/bin:$PATH"

#############################################################################

export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
umask 022

#############################################################################

eval "`dircolors`"

#############################################################################

export HISTFILESIZE=99999999
export HISTSIZE=99999999
export HISTCONTROL="ignoreboth"

#############################################################################
