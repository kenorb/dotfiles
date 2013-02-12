# FUNCTIONS

# Change dir via find
# Usage: cdf (dir)
cdf() {
  cd $(find . -name $1)
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
alias ll='ls -laG'   # Unix like ls

