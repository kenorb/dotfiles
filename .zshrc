# ~/.zshrc: executed by zsh(1) for non-login shells.

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.
# See /usr/share/doc/zsh-doc/examples in the zsh-doc package.

if [ -f ~/.aliasesrc ]; then
    . ~/.aliasesrc
fi

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Load private secret settings.
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

# Controls which default set of key bindings is used.
set -o vi

# Allow a reverse history search in vi-mode.
# https://unix.stackexchange.com/q/44115/21471
bindkey "^R" history-incremental-search-backward
