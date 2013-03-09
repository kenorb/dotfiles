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

# ALIASES
alias ll='ls -laF'   # Unix like ls

