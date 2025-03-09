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

if [ -f ~/.aliasesrc_rg ]; then
  . ~/.aliasesrc_rg
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

# Configure dagger completion.
if type dagger &>/dev/null; then
  mkdir -vp "$HOME"/.local/share/bash-completion/completions
  dagger completion bash > "$HOME"/.local/share/bash-completion/completions/dagger
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

# Wasienv
export WASIENV_DIR="$HOME/.wasienv"
[ -s "$WASIENV_DIR/wasienv.sh" ] && source "$WASIENV_DIR/wasienv.sh"

export PATH="/usr/local/cuda-11.7/bin:$PATH"
#export LD_LIBRARY_PATH="/usr/local/cuda-11.7/lib64"
export PM_PACKAGES_ROOT=$HOME/packman-repo

# >>> conda initialize >>>
if [ -d "$HOME/anaconda3/bin/conda" ]; then
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.bash' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
      . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
      export PATH="$HOME/anaconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
fi

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi
