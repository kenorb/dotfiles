# Initialize
echo .profile loaded.

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

