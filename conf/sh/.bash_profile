# Initialize
echo .bash_profile loaded.
. ~/.profile

# FUNCTIONS

# Change dir via find
# Usage: cdf (dir)
cdf() {
  pushd $(find . -name $1)
}

# Find file
# Usage: ff (file)
ff() {
  find . -name $1
}

# Vim file via find
# Usage: ff (file)
vimf() {
  vim $(find . -name $1)
}

# Find duplicate files
# Usage: dups (dir)
dups() {
  fdupes -v && fdupes -rS1 $1 | sed '$!N;s/\n/ /' | sort -n
}

# ALIASES
alias ll='ls -laF'   # Unix like ls


# added by Anaconda 1.5.1 installer
# export PATH="/Users/kenorb/anaconda/bin:$PATH"
