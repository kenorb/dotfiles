# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Add a Composer's global bin directory if exists.
which composer >/dev/null && export PATH="$HOME/.composer/vendor/bin:$PATH"

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
echo $(basename $BASH_SOURCE) loaded.

# Check the requirements.
if [ "${BASH_VERSION:0:1}" -eq 3 ]; then
  echo "Please upgrade your bash to >= 4."
fi

# Detect the platform (similar to $OSTYPE)
case "$OSTYPE" in

  solaris*)
    ;;

  darwin*) # Mac (OSX)

    # Set LC encoding to UTF-8.
    export LC_ALL=en_GB.UTF-8

    # For MAMP (OSX)
    PHP_VER="5.6.10" # Or: 5.4.19/5.5.3 ($ls /Applications/MAMP/bin/php/php*)

    # Set PATH for OSX
    export PATH=/Applications/MAMP/Library/bin:/Applications/MAMP/bin/php/php$PHP_VER/bin:/usr/local/sbin:/usr/local/bin:$PATH:/Developer/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin/gcc
    export PATH=$PATH:$HOME/bin:$HOME/binfiles
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # add a "gnubin" for coreutils
    export PYTHONPATH="$PYTHONPATH:$HOME/.python"
    # :/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang

    # Development variables.
    export HOMEBREW_GITHUB_API_TOKEN=0ff93b1c7cc8efdf109d169899a12852dfd566c8
    export FLEX_HOME=/usr/local/Cellar/flex_sdk/4.6.0.23201/libexec
    export DYLD_FALLBACK_LIBRARY_PATH="/usr/X11/lib:/usr/lib" # See: http://stackoverflow.com/questions/10820981/dylibs-and-os-x

    # Fix for Git-SVN (OSX) [Error: Can't locate SVN/Core.pm in @INC]. See: http://stackoverflow.com/questions/13571944/git-svn-unrecognized-url-scheme-error
    export PERL5LIB="/Users/$USER/perl5/lib/perl5:/Applications/Xcode.app/Contents/Developer/Library/Perl/5.16"

    # OSX specific aliases.
    alias diffmerge="/Applications/DiffMerge.app/Contents/MacOS/DiffMerge"
    alias xt-files="egrep -o '/[^/]+:[0-9]+'"
    alias iphone="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone Simulator.app/Contents/MacOS/iPhone Simulator" # OSX Lion

    # Set other options.
    export LS_OPTIONS='-G -h'

    # OSX: Enable bash_completion (Install by: brew install bash-completion)
    #       Homebrew's own bash completion script: /usr/local/etc/bash_completion.d
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
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
    # Set LC encoding to UTF-8.
    # Ubuntu way: Use locale-gen (part of locales).
    export LANG=en_GB.UTF-8
    export LANGUAGE="en_GB:en"

    # Set PATH for Linux
    export PATH=/usr/local/bin:$PATH:/opt/local/bin

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

    # Linux aliases
    # Add an "alert" alias for long running commands. Use like so: sleep 10; alert
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

    # Set other options.
    export LS_OPTIONS='--color=auto -h'

    ;;

  bsd*)
    export LS_OPTIONS='-G'
    ;;

  *)
    echo "Unknown: $OSTYPE"
    ;;
esac

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

# If set, the extended pattern matching features are enabled. See: http://wiki.bash-hackers.org/syntax/pattern
shopt -s extglob

# make less more friendly for non-text input files, see lesspipe(1)
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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
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

# Exports
export EDITOR='vim'
export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/Users/$USER/perl5"
export PERL_MB_OPT="--install_base /Users/$USER/perl5"
export PERL_MM_OPT="INSTALL_BASE=/Users/$USER/perl5"
export PERL5LIB="/Users/$USER/perl5/lib/perl5:$PERL5LIB"
export PATH="/Users/$USER/perl5/bin:$PATH"

export PATH="$PATH:/Applications/DevDesktop/drush"
