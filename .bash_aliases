# ~/.bash_aliases

# ALIASES #
#
# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
echo $(basename $BASH_SOURCE) loaded.

#
# ls variants
#alias lsd='ls -d .*'
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -alF' # Unix like ls
alias la='ls $LS_OPTIONS -A'
alias l='ls $LS_OPTIONS -alFtr'
#alias l='ls $LS_OPTIONS -lA'
#alias l='ls $LS_OPTIONS -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias s='ssh -l root'

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
alias big='du -ah . | sort -rh | head -20'
# List top ten largest files in current directory
alias big-files='ls -1Rhs | sed -e "s/^ *//" | grep "^[0-9]" | sort -hr | head -n20'
# What's gobbling the memory?
alias psmem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'
# Get external IP
alias ifconfig-ext='curl ifconfig.me' # Or: ip.appspot.com
#
# wget (if available)
alias wget-all='wget --user-agent=Mozilla -e robots=off --content-disposition --mirror --convert-links -E -K -N -r -c'
#
# youtube-dl (if available)
alias youtube-dl='youtube-dl -vcti -R5 --write-description --write-info-json --all-subs --write-thumbnail --add-metadata'
#
# Other
# Find xdebug files.
#alias xt-files='egrep -o "/[^/]+:[0-9]+"'

# Useful converting tools.
alias urldecode='sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b"'

# OSX
alias swap_on="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
alias swap_off="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
alias sql_istat='grep -oE "INTO `\w+`" | grep -oE "`\w+`" | sort | uniq -c | sort -nr'
alias kcrash_verbose='sudo nvram boot-args="-v keepsyms=y"'
alias DiskUtility_debug='defaults write com.apple.DiskUtility DUDebugMenuEnabled 1' # http://osxdaily.com/2011/09/23/view-mount-hidden-partitions-in-mac-os-x/
alias eject_force="diskutil unmountDisk force"
# Reload DNS on OSX
alias flushdns="dscacheutil -flushcache"
# Changes Terminal title.
alias title="printf '\033]0;%s\007'"
# Set Mac System Sleep Idle Time
alias systemsleep="sudo systemsetup -setcomputersleep"
alias startup="osascript -e 'tell application \"System Events\" to get name of every login item'"
alias kextstat_noapple='kextstat -kl | grep -v com.apple'
alias jobs_other='sudo launchctl list | sed 1d | awk "!/0x|com\.(apple|openssh|vix)|edu\.mit|org\.(amavis|apache|cups|isc|ntp|postfix|x)/{print $3}"'

# Start/stop indexing on all volumes.
alias spotlight_off='sudo mdutil -a -i off'
alias spotlight_on='sudo mdutil -a -i on'

# Load/unload Spotlight Launch Daemons.
alias spotlight_unload='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'
alias spotlight_load='sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'

# LINUX
# Open any file with the default command for that file
# alias open='xdg-open'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#
# Various
alias h='history | tail'
alias mv='mv -v' 
alias rm='rm -v'

# One letter quickies:
alias p='pwd'
alias x='exit'

#
# Directories
alias s='cd ..'
alias play='cd ~/play/'

#
# Rails
#alias src='script/rails console'
#alias srs='script/rails server'
#alias raked='rake db:drop db:create db:migrate db:seed' 
#alias rvm-restart='source '\''/home/durrantm/.rvm/scripts/rvm'\'''
#alias rrg='rake routes | grep '
#alias rspecd='rspec --drb '

#
# DropBox - syncd
#WORKBASE="~/Dropbox/97_2012/work"
#alias work="cd $WORKBASE"
#alias code="cd $WORKBASE/ror/code"

#
# DropNot - NOT syncd !
#WORKBASE_GIT="~/Dropnot"
#alias {dropnot,not}="cd $WORKBASE_GIT"
#alias {webs,ww}="cd $WORKBASE_GIT/webs"
#alias {setups,docs}="cd $WORKBASE_GIT/setups_and_docs"
#alias {linker,lnk}="cd $WORKBASE_GIT/webs/rails_v3/linker"

# Utils
alias dos2unix="ex +'bufdo!%!tr -d \r' -scxa"

#
# git
alias {gsta,gst}='git status' 
# Warning: gst conflicts with gnu-smalltalk (when used).
alias {gbra,gb}='git branch'
alias {gco,go}='git checkout'
alias {gcob,gob}='git checkout -b '
alias {gadd,ga}='git add '
alias {gcom,gc}='git commit'
alias {gpul,gl}='git pull '
alias {gpus,gh}='git push '
alias glom='git pull origin master'
alias ghom='git push origin master'
alias gg='git grep '
alias cdgit='cd "$(git rev-parse --show-toplevel 2> /dev/null)"'
alias git-pull-all='find $(git rev-parse --show-toplevel 2> /dev/null) -name .git -type d -execdir git pull -v ";"'


#
# vim/vi/ex
alias v='vim'
alias trim="ex +'bufdo!%s/\s\+$//e' -scxa" # Strip trailing whitespaces.
alias retab="ex +'set ts=2' +'bufdo retab' -scxa" # Convert tabs to spaces.

#
# tmux
#alias {ton,tn}='tmux set -g mode-mouse on'
#alias {tof,tf}='tmux set -g mode-mouse off'

