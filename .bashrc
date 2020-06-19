# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
RC_LOADED+=($(basename $BASH_SOURCE))
[ ${BASH_VERSION:0:1} -gt 3 ] && echo "${RC_LOADED[-1]} loaded." >&2

# If ~/.bash_profile exists and was not loaded, source that too.
[ -f "$HOME"/.bash_profile ] && [[ ! ${RC_LOADED[@]} =~ ".bash_profile" ]] && . "$HOME"/.bash_profile

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliasesrc ]; then
  . ~/.aliasesrc
fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# added by travis gem
[ -f /home/kenorb/.travis/travis.sh ] && source /home/kenorb/.travis/travis.sh
