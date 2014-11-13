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

# GLOBAL VARIABLES #
# Set architecture flags for x64
export ARCHFLAGS="-arch x86_64"
export LANG=C LC_CTYPE=C # Fixes for sed, see: http://www.delorie.com/gnu/docs/gawk/gawk_149.html, http://stackoverflow.com/q/19242275/55075

# ALIASES #

# Getting colored results when using a pipe from grep to less.
alias less='less -R'
# Recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
# Unix like ls
alias ll='ls -laF'
# Jump back n directories at a time
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
# Compact, colorized git log
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# Visualise git log (like gitk, in the terminal)
alias lg='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
# Show which commands you use the most
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
# Show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'
# Allow to find the biggest file or directory in the current directory.
alias ds='du -ks *|sort -n'
# List top ten largest files/directories in current directory
alias big='du -cks *|sort -rn|head -20'
# List top ten largest files in current directory
alias big-files='find -type f -ls | sort -k7 -r -n | head -20'
# What's gobbling the memory?
alias psmem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
# Get external IP
alias ifconfig-ext='curl ifconfig.me' # Or: ip.appspot.com

# Other
alias youtube-dl='youtube-dl -vcti -R5 --write-description --write-info-json --all-subs --write-thumbnail --add-metadata'
alias xt-files='egrep -o "/[^/]+:[0-9]+"'
alias wget-all='wget --user-agent=Mozilla -e robots=off --content-disposition --mirror --convert-links -E -K -N -r -c'
# OSX
alias swap_on="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
alias swap_off="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
alias sql_istat='grep -oE "INTO `\w+`" | grep -oE "`\w+`" | sort | uniq -c | sort -nr'
alias kcrash_verbose='sudo nvram boot-args="-v keepsyms=y"'
alias DiskUtility_debug='defaults write com.apple.DiskUtility DUDebugMenuEnabled 1' # http://osxdaily.com/2011/09/23/view-mount-hidden-partitions-in-mac-os-x/
alias eject_force="diskutil unmountDisk force"
# Reload DNS on OSX
alias flushdns="dscacheutil -flushcache"

# LINUX
# Open any file with the default command for that file
# alias open='xdg-open'

# added by Anaconda 1.5.1 installer
# export PATH="/Users/$USER/anaconda/bin:$PATH"
