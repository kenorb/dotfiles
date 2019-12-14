# Bundler file for non-Ruby dependencies from Homebrew.
# Usage: brew bundle -v
# @docs https://github.com/Homebrew/homebrew-bundle#usage

# Taps.
tap "microsoft/mssql-preview", "https://github.com/Microsoft/homebrew-mssql-preview"

# Brew (CLI).
brew "bash"
brew "bash-completion"
brew "imagemagick"
brew "mackup"
brew "youtube-dl"

# Brew (databases).
brew "sqlite"
#brew "msodbcsql"
#brew "mssql-tools" # Homebrew/homebrew-bundle/issues/604
#brew "mysql@5.6", restart_service: true, link: true, conflicts_with: ["mysql"]

# Brew (development).
brew "ack"
brew "direnv"
brew "docker-compose"
brew "git"
brew "git-lfs"
brew "hub"
brew "jq"
brew "node"
brew "python3"
brew "rbenv"
brew "redis"
brew "ripgrep"
brew "ruby-build"
brew "unixodbc" # for msodbcsql
brew "vim"
brew "yq"
#brew "denji/nginx/nginx-full", args: ["with-rmtp-module"]

# Casks (DevOps).
brew "ansible"
brew "azure-cli"
brew "terraform"

# Brew (linters/formatters).
brew 'shellcheck'
brew 'shfmt'
brew 'tflint'
brew 'yamllint'

# Casks (Setup).
tap "homebrew/cask"
tap "homebrew/cask-versions"
cask_args appdir: "/Applications"

# Casks (Apps).
cask "alfred"
cask "balsamiq-mockups"
cask "bartender"
cask "caffeine"
cask "docker"
cask "dropbox"
cask "evernote"
cask "kindle"
cask "qbittorrent"
cask "the-unarchiver"
cask "wine-devel"

# Casks (development).
cask "android-file-transfer"
cask "ccmenu"
cask "charles"
cask "dash"
cask "dropbox"
cask "evernote"
cask "hyper"
cask "iterm2"
cask "java" unless system "/usr/libexec/java_home --failfast"
cask "keepassx"
cask "reflector"
cask "sublime-text"
cask 'visual-studio-code'
#cask "vagrant"
#cask "virtualbox"

# Casks (Games).
cask "openemu"
cask "steam"

# Casks (Media).
cask "vlc"
cask "mplayerx"

# Casks (Libraries).
cask "flux"
cask "xquartz"

# Casks (Security apps).
cask 'dashlane'

# Casks (Social).
cask "google-hangouts"
cask "skype"
cask "slack"
cask 'telegram'
cask 'zoom'

# Casks (Web browsers).
cask "brave-browser"
cask "firefox"
cask "google-chrome"
cask "opera"
