# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Initialize
echo .profile loaded.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 0022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# EXPORTS
export PATH=/usr/local/bin:$PATH:/opt/local/bin
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

## For MAC ##
export DYLD_FALLBACK_LIBRARY_PATH="/usr/X11/lib:/usr/lib"
# For Development
export PATH=$PATH:/opt/local/bin:/Developer/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin/gcc
# :/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
# For MAMP
export PATH=/Applications/MAMP/Library/bin:/Applications/MAMP/bin/php/php5.3.20/bin:$PATH

# Aliases
alias ll='ls -alF'   # Unix like ls
alias diffmerge="/Applications/DiffMerge.app/Contents/MacOS/DiffMerge"
# alias dc="drush -yv -l 'http://drupal'"

alias iphone="/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app/Contents/MacOS/iPhone\ Simulator"

