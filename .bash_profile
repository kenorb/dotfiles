# Initialize
# Determine within a startup script whether Bash is running interactively or not.
if [ ! -z "$PS1" ]; then
  echo .bash_profile loaded.
fi

# Load user profile file
. ~/.profile

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

# Find duplicate files
# Usage: dups (dir)
dups() {
  fdupes -v && fdupes -rS1 $1 | sed '$!N;s/\n/ /' | sort -n
}

# Find the top 10 largest files
# Usage: big (dir)
big() {
  find . $1 -type f -ls | sort -k7 -r -n | head -20
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

# ALIASES
alias ll='ls -laF'   # Unix like ls
alias youtube-dl='youtube-dl -vcti -R5 --write-description --write-info-json --all-subs --write-thumbnail'
alias xt-files='egrep -o "/[^/]+:[0-9]+"'
alias wget-all='wget --user-agent=Mozilla -e robots=off --content-disposition --mirror'
# OSX
alias swap_on="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
alias swap_off="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
alias sql_istat='grep -oE "INTO `\w+`" | grep -oE "`\w+`" | sort | uniq -c | sort -nr'


# added by Anaconda 1.5.1 installer
# export PATH="/Users/kenorb/anaconda/bin:$PATH"
