# .bash_profile
# Invoked by .bashrc file.

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
echo "$(basename $BASH_SOURCE) loaded." >&2

# Load user ~/.profile file regardless of shell version
[ -e "$HOME"/.profile ] && . "$HOME"/.profile

# If POSIXLY_CORRECT is set after doing that, force the `posix` option on and
# don't load the rest of this stuff--so, just ~/.profile and ENV
if [ -n "$POSIXLY_CORRECT" ] ; then
    set -o posix
    return
fi

# If ~/.bashrc exists, source that too; the tests for both interactivity and
# >=2.05a (for features like [[) are in there
#[ -f "$HOME"/.bashrc ] && . "$HOME"/.bashrc

#############################################################################

export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
export PROMPT_DIRTRIM=2
umask 022

which dircolors && eval "`dircolors`"

# Changes the ulimit limits.
ulimit -Sn 4096      # open files
ulimit -Sl unlimited # max locked memory

# Enable Bash auto-completion for Drupal Console if exists.
[ -f "$HOME/.console/console.rc" ] && source "$HOME/.console/console.rc" 2>/dev/null

# Git variables.
export GITAWAREPROMPT=~/.bash/git-aware-prompt
[ -f "${GITAWAREPROMPT}/main.sh" ] && source "${GITAWAREPROMPT}/main.sh"

# Added by Travis gem.
[ -f $HOME/.travis/travis.sh ] && source ~/.travis/travis.sh
