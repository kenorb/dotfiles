# ~/.bash_aliases

## ALIASES ##

# Initialize
RC_LOADED+=($(basename $BASH_SOURCE))
[ ${BASH_VERSION:0:1} -gt 3 ] && echo "${RC_LOADED[-1]} loaded." >&2

## File system

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Show which commands you use the most
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
# Allow to find the biggest file or directory in the current directory.
alias ds='du -ks *|sort -n'
# List top ten largest files/directories in current directory
alias big='du -ah . | sort -rh | head -40'
# List top ten largest files in current directory
alias big-files='ls -1Rhs | sed -e "s/^ *//" | grep "^[0-9]" | sort -hr | head -n40'
# What's gobbling the memory?
alias psmem='ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6 | tail -15'

## Network

# Get external IP
alias whatismyip='curl ifconfig.me' # Or: ip.appspot.com

# Show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'

## Downloading

#
# wget (if available)
alias wget-all='wget --user-agent=Mozilla -e robots=off --content-disposition --mirror --convert-links -E -K -N -r -c'
#
# youtube-dl (if available)
alias youtube-dl='youtube-dl -vci -R5 -f "(webm,mp4)" --write-description --write-info-json --all-subs --write-thumbnail --add-metadata'
#
# Move torrent files
alias move_torrents='find . -name "*.torrent" -exec sh -c '\''DST=$(find . -type d -name "$(basename "{}" .torrent)" -print -quit); [ -d "$DST" ] && mv -v "{}" "$DST/"'\'' ";"'

## Conversion

# Useful converting tools.
alias urldecode='sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b"'

type jq >/dev/null 2>&1 \
  && alias urlencode='jq -rRs @uri' \
  || alias urlencode='curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" | cut -c3-'

# Other
# Find xdebug files.
#alias xt-files='egrep -o "/[^/]+:[0-9]+"'

## OSX
alias bypass="/System/Library/Extensions/TMSafetyNet.kext/Contents/Helpers/bypass"
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
alias git-svn='/Applications/Xcode.app/Contents/Developer/usr/libexec/git-core/git-svn'
alias unpause="pkill -CONT -u $UID"
alias trace-kernel="sudo fs_usage | grep -v 0.00"
alias disable-local-backups="sudo tmutil disablelocal"
alias enable-local-backups="sudo tmutil enablelocal"

## DTrace
alias trace-php='sudo dtrace -qn "php*:::function-entry { printf(\"%Y: PHP function-entry:\t%s%s%s() in %s:%d\n\", walltimestamp, copyinstr(arg3), copyinstr(arg4), copyinstr(arg0), basename(copyinstr(arg1)), (int)arg2); }"'
# Files opened by process.
alias trace-files="sudo dtrace -qn 'syscall::open*:entry { printf(\"%s %s\n\",execname,copyinstr(arg0)); }'"
# Syscall count by program.
alias trace-count-by-program="sudo dtrace -n 'syscall:::entry { @num[execname] = count(); }'"
# Syscall count by syscall.
alias trace-count-by-syscall="sudo dtrace -n 'syscall:::entry { @num[probefunc] = count(); }'"
# Syscall count by process.
alias trace-count-by-process="sudo dtrace -n 'syscall:::entry { @num[pid,execname] = count(); }'"

# Memcached
alias flush-memcache='echo flush_all > /dev/tcp/localhost/11211'

# Start/stop indexing on all volumes.
alias spotlight-off='sudo mdutil -a -i off'
alias spotlight-on='sudo mdutil -a -i on'

# Load/unload Spotlight Launch Daemons.
alias spotlight-unload='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'
alias spotlight-load='sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'

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
alias h='history | grep '
alias mv='mv -v' 
alias rm='rm -v'

# One letter quickies:
alias p='pwd'
alias x='exit'

#
# Directories
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

# Helper Drush/Drupal-related aliases
alias drush-dump7="drush sql-dump --ordered-dump --structure-tables cache,cache_filter,cache_menu,cache_page,history,sessions,watchdog --result-file=dump.sql"
alias vagrant-suspend-all="vagrant global-status | awk '/running/{print $1}' | gxargs -r -d '\n' -n 1 -- vagrant suspend"

# Utils
alias dos2unix="ex +'bufdo! %! tr -d \\\\r' -scxa"

#
# tmux
#alias {ton,tn}='tmux set -g mode-mouse on'
#alias {tof,tf}='tmux set -g mode-mouse off'
