# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Initialize
# Determine within a startup script whether Bash is running interactively or not.
if [ ! -z "$PS1" ]; then
  echo .profile loaded.
fi

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
export DYLD_FALLBACK_LIBRARY_PATH="/usr/X11/lib:/usr/lib" # http://stackoverflow.com/questions/10820981/dylibs-and-os-x
# For Development
export PATH=$PATH:/usr/local/sbin:/opt/local/bin:/Developer/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin/gcc
export HOMEBREW_GITHUB_API_TOKEN=0ff93b1c7cc8efdf109d169899a12852dfd566c8
export FLEX_HOME=/usr/local/Cellar/flex_sdk/4.6.0.23201/libexec
# :/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
# For MAMP (OSX)
PHP_VER="5.5.3"
PHP_VER="5.4.19"
export PATH=/Applications/MAMP/Library/bin:/Applications/MAMP/bin/php/php$PHP_VER/bin:$PATH
# Fix for Git-SVN (OSX) [Error: Can't locate SVN/Core.pm in @INC]. See: http://stackoverflow.com/questions/13571944/git-svn-unrecognized-url-scheme-error
export PERL5LIB="/Users/kenorb/perl5/lib/perl5:/Applications/Xcode.app/Contents/Developer/Library/Perl/5.16"

# Aliases
alias ll='ls -alF'   # Unix like ls
alias diffmerge="/Applications/DiffMerge.app/Contents/MacOS/DiffMerge"
alias xt-files="egrep -o '/[^/]+:[0-9]+'"
# alias dc="drush -yv -l 'http://drupal'"

alias iphone="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone Simulator.app/Contents/MacOS/iPhone Simulator" # OSX Lion

