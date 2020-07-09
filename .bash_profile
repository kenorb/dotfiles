# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
[ -z "$PS1" ] && return
RC_LOADED+=($(basename $BASH_SOURCE))
[ ${BASH_VERSION:0:1} -gt 3 ] && echo "${RC_LOADED[-1]} loaded." >&2

# Load user ~/.profile file regardless of shell version
[ -e "$HOME"/.profile ] && . "$HOME"/.profile

# If POSIXLY_CORRECT is set after doing that, force the `posix` option on and
# don't load the rest of this stuff--so, just ~/.profile and ENV
if [ -n "$POSIXLY_CORRECT" ]; then
  set -o posix
  return
fi

# If ~/.bashrc exists, source that too; the tests for both interactivity and
# >=2.05a (for features like [[) are in there
[ -f "$HOME"/.bashrc ] && [[ ! ${RC_LOADED[@]} =~ ".bashrc" ]] && . "$HOME"/.bashrc

#############################################################################

# Changes the ulimit limits.
ulimit -Sn 4096      # open files
ulimit -Sl unlimited # max locked memory

# Enable Bash auto-completion for Drupal Console if exists.
[ -f "$HOME/.console/console.rc" ] && source "$HOME/.console/console.rc" 2>/dev/null

# Git variables.
export GITAWAREPROMPT=~/.bash/git-aware-prompt
[ -f "${GITAWAREPROMPT}/main.sh" ] && source "${GITAWAREPROMPT}/main.sh"

# Includes common shell exports
if [ -f ~/.exportsrc ]; then
  . ~/.exportsrc
fi

# Includes Bash shell exports
if [ -f ~/.bash_exports ]; then
  . ~/.bash_exports
fi

# Includes shell options.
if [ -f ~/.bash_options ]; then
  . ~/.bash_options
fi

# Includes function definitions.
if [ -f ~/.functionsrc ]; then
  . ~/.functionsrc
fi

# Detect the platform.
case "$OSTYPE" in

solaris*) ;;

darwin*) # macOS

  # Load macOS specific shell exports.
  if [ -f ~/.bash_exports_macos ]; then
    . ~/.bash_exports_macos
  fi

  # Enable bash_completion (Install by: brew install bash-completion)
  # Homebrew's own bash completion script: /usr/local/etc/bash_completion.d
  if type brew &>/dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

  # Brew's perl package.
  if [ -d "$HOME"/perl5/lib/perl5 ]; then
    # Install via: # PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
    # By default non-brewed cpan modules are installed to the Cellar.
    # This makes your modules to persist across updates we recommend using `local::lib`.
    eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
  fi

  ;;

linux-gnu*) # Debian

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
  xterm-color | *-256color) color_prompt=yes ;;
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

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *) ;;

  esac

  # Load Linux specific shell exports.
  if [ -f ~/.bash_exports_linux ]; then
    . ~/.bash_exports_linux
  fi

  ;;

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

  # Load Linux specific shell exports.
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

# Load Bash-specific startup files.
for sh in "$HOME"/.bashrc.d/*.bash; do
  [[ -e $sh ]] && source "$sh"
done

# Added by Travis gem.
[ -f $HOME/.travis/travis.sh ] && source ~/.travis/travis.sh

# Load private secret settings.
if [ -f ~/.secrets ]; then
  . ~/.secrets
fi

# Setup kubectl autocomplete.
if command -v kubectl &>/dev/null; then
  source <(kubectl completion bash)
fi
