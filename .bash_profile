# .bash_profile
# Invoked by .bashrc file.

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
echo "$(basename $BASH_SOURCE) loaded." >&2

# Load user profile file
if [ -f ~/.profile ]; then
  . ~/.profile
fi

#############################################################################

export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
export PROMPT_DIRTRIM=2
umask 022

which dircolors && eval "`dircolors`"
