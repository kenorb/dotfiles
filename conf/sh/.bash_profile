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

# Find the top 10 largest files
# Usage: big (dir)
big() {
  find . $1 -type f -ls | sort -k7 -r -n | head -10
}

# ALIASES
alias ll='ls -laF'   # Unix like ls
alias youtube-dl='youtube-dl -vcti -R5 --write-description --write-info-json --all-subs --write-thumbnail'


# added by Anaconda 1.5.1 installer
# export PATH="/Users/kenorb/anaconda/bin:$PATH"
