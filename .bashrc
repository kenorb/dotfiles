# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Add a Composer's global bin directory if exists.
which composer >/dev/null && export PATH="$HOME/.composer/vendor/bin:$PATH"

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
echo "$(basename $BASH_SOURCE) loaded." >&2

# Check the requirements.
if [ "${BASH_VERSION:0:1}" -eq 3 ]; then
  echo "Please upgrade your bash to >= 4." >&2
fi

# Detect the platform.
case "$OSTYPE" in

  solaris*)
    ;;

  darwin*) # Mac (OSX)

    # Set LC encoding to UTF-8.
    #export LC_ALL=en_GB.UTF-8

    # Fixes for illegal byte sequence (http://stackoverflow.com/q/19242275/55075).
    export LC_ALL=C
    export LANG=C

    # Set PATH for OSX
    type brew > /dev/null && brew --prefix homebrew/php/php71 > /dev/null && export PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"
    export PATH="$PATH:/Developer/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin/gcc"
    export PATH="$PATH:/Applications/MAMP/Library/bin:/Applications/MAMP/bin/php/php5.6.10/bin"
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # add a "gnubin" for coreutils
    export PYTHONPATH="$PYTHONPATH:$HOME/.python" # /usr/local/lib/python3.4/site-packages"
    # :/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang

    # Development variables.
    export FLEX_HOME="/usr/local/Cellar/flex_sdk/4.6.0.23201/libexec"
    export DYLD_FALLBACK_LIBRARY_PATH="/usr/X11/lib:/usr/lib" # See: http://stackoverflow.com/questions/10820981/dylibs-and-os-x
    #export PHP_AUTOCONF="$(which autoconf)" # Install autoconf, which is needed for the installation of phpMyAdmin.

    # Fix for Git-SVN (OSX) [Error: Can't locate SVN/Core.pm in @INC]. See: http://stackoverflow.com/questions/13571944/git-svn-unrecognized-url-scheme-error
    export PERL5LIB="$HOME/perl5/lib/perl5:/Applications/Xcode.app/Contents/Developer/Library/Perl/5.16"

    # macOS specific aliases.
    if [ -f ~/.bash_aliases_macos ]; then
        . ~/.bash_aliases_macos
    fi

    # Set prompt
    export GIT_PS="\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\] "
    export PS1="\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\W \[\033[01;35m\]\$ $GIT_PS\[\033[00m\]"

    # Set other options.
    export LS_OPTIONS='-G -h'

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

    # Linux specific aliases.
    if [ -f ~/.bash_aliases_linux ]; then
        . ~/.bash_aliases_linux
    fi

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

    # Linux specific aliases.
    if [ -f ~/.bash_aliases_linux ]; then
        . ~/.bash_aliases_linux
    fi

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# Ref: /usr/share/doc/bash-doc/examples in the bash-doc package.
# @see: https://ss64.com/bash/syntax-bashrc.html
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi
if [ -f ~/.bash_options ]; then
    . ~/.bash_options
fi

# Load private secret settings.
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

# Enable Bash auto-completion for Drupal Console if exists.
[ -f "$HOME/.console/console.rc" ] && source "$HOME/.console/console.rc" 2>/dev/null

# Git variables.
export GITAWAREPROMPT=~/.bash/git-aware-prompt
[ -f "${GITAWAREPROMPT}/main.sh" ] && source "${GITAWAREPROMPT}/main.sh"

# Added by Travis gem.
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
