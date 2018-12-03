# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

[ -z "$PS1" ] && return
echo "$(basename $BASH_SOURCE) loaded." >&2

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Don't do anything if restricted, not even sourcing the ENV file
# Testing $- for "r" doesn't work
# shellcheck disable=SC2128
[ -n "$BASH_VERSINFO" ] && shopt -q restricted_shell && return

# If ENV is set, source it to get all the POSIX-compatible interactive stuff;
# we should be able to do this even if we're running a truly ancient Bash
[ -n "$ENV" ] && . "$ENV"

# Clear away command_not_found_handle if a system bashrc file set it up
unset -f command_not_found_handle

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# Ref: /usr/share/doc/bash-doc/examples in the bash-doc package.
# @see: https://ss64.com/bash/syntax-bashrc.html
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Includes function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Includes shell options.
if [ -f ~/.bash_options ]; then
    . ~/.bash_options
fi

# Includes shell exports
if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

# Check the requirements.
if [ "${BASH_VERSION:0:1}" -eq 3 ]; then
  echo "Please upgrade your bash to >= 4." >&2
fi

# Detect the platform.
case "$OSTYPE" in

  solaris*)
    ;;

  darwin*) # macOS

    # macOS specific aliases.
    if [ -f ~/.bash_aliases_macos ]; then
        . ~/.bash_aliases_macos
    fi

    # macOS specific shell exports.
    if [ -f ~/.bash_exports_macos ]; then
        . ~/.bash_exports_macos
    fi

    # OSX: Enable bash_completion (Install by: brew install bash-completion)
    #       Homebrew's own bash completion script: /usr/local/etc/bash_completion.d
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi

    # macOS: Brew's perl package.
    if [ -d "$HOME"/perl5/lib/perl5 ]; then
      # Install via: # PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
      # By default non-brewed cpan modules are installed to the Cellar.
      # This makes your modules to persist across updates we recommend using `local::lib`.
      eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
    fi

    ;;

  linux-gnu*) # Debian

    # Debian specific
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
    fi

    if [ "$color_prompt" = yes ]; then
      PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
      PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
      ;;
    *)
      ;;
    esac

    ;;& # fall-through syntax requires bash >= 4; (OSX, check: http://apple.stackexchange.com/q/141752/22781)

  linux*)

    # Linux: enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi

    # Linux: Enable bash_completion (Install by: brew install bash-completion)
    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    # Install by: sudo apt-get install bash-completion
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi

    # Linux specific aliases.
    if [ -f ~/.bash_aliases_linux ]; then
        . ~/.bash_aliases_linux
    fi

    # Linux specific shell exports.
    if [ -f ~/.bash_exports_linux ]; then
        . ~/.bash_exports_linux
    fi

    ;;

  bsd*)

    export LS_OPTIONS='-G'
    ;;

  *)
    echo "Unknown: $OSTYPE"
    ;;
esac

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
fi
unset color_prompt force_color_prompt

# Load Bash-specific startup files.
for sh in "$HOME"/.bashrc.d/*.bash ; do
    [[ -e $sh ]] && source "$sh"
done

# Load private secret settings.
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi
