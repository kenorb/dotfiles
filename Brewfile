# Bundler file for non-Ruby dependencies from Homebrew.
# Usage: brew bundle -v
# @docs https://github.com/Homebrew/homebrew-bundle#usage

# Taps.
tap "microsoft/mssql-preview", "https://github.com/Microsoft/homebrew-mssql-preview"

# Brew Apps.
brew "ack"
brew "azure-cli"
brew "bash-completion"
#brew "denji/nginx/nginx-full", args: ["with-rmtp-module"]
brew "direnv"
brew "git"
brew "git-lfs"
brew "hub"
brew "imagemagick"
brew "jq"
brew "mackup"
#brew "msodbcsql"
#brew "mssql-tools" # Homebrew/homebrew-bundle/issues/604
#brew "mysql@5.6", restart_service: true, link: true, conflicts_with: ["mysql"]
brew "node"
brew "python3"
brew "rbenv"
brew "redis"
brew "ruby-build"
brew "shellcheck"
brew "shfmt"
brew "sqlite"
brew "terraform"
brew "tflint"
brew "unixodbc" # for msodbcsql
brew "vim"
brew "yamllint"
brew "yq"

# Casks (Setup).
tap "homebrew/cask"
cask_args appdir: "/Applications"

# Casks (Dev Tools).
cask "ccmenu"
cask "dash"
cask "dropbox"
cask "evernote"
cask "hyper"
cask "iterm2"
cask "java" unless system "/usr/libexec/java_home --failfast"
cask "reflector"
cask "sublime-text"
cask "vagrant"
cask "virtualbox"

# Casks (Apps).
cask "alfred"
cask "balsamiq-mockups"
cask "bartender"
cask "caffeine"
cask "dropbox"
cask "evernote"
cask "flux"
cask "google-hangouts"
cask "mplayerx"
cask "openemu"
cask "qbittorrent"
cask "skype"
cask "steam"
cask "the-unarchiver"

# Casks (Security apps).
cask 'dashlane'

# Casks (Web browsers).
cask "brave"
cask "firefox"
cask "google-chrome"
cask "opera-next"
