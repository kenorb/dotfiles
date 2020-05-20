# Bundler file for non-Ruby dependencies from Homebrew.
# Usage: ACCEPT_EULA=y brew bundle install -v
# @docs https://github.com/Homebrew/homebrew-bundle#usage

# Taps.
tap 'microsoft/mssql-release', 'https://github.com/Microsoft/homebrew-mssql-release'

# Brew (CLI).
brew "afsctool"
brew "bash"
brew "bash-completion"
brew "curl-openssl"
brew "imagemagick"
brew "mackup"
brew "transmission"
brew "wget"
brew "youtube-dl"

# Brew (GNU).
# https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
brew "coreutils"
brew "diffutils"
brew "findutils"
brew "gawk"
brew "gdb" # gdb requires special privileges. See `brew info gdb`.
brew "gnu-indent"
brew "gnu-sed"
brew "gnu-tar"
brew "gnu-which"
brew "gnutls"
brew "grep"
brew "gzip"
brew "screen"
brew "watch"
brew "wdiff"

# Brew (databases).
brew "h2"
brew "postgres"
brew "sqlite"
#brew "msodbcsql"
#brew "mssql-tools" # Homebrew/homebrew-bundle/issues/604
#brew "mysql@5.6", restart_service: true, link: true, conflicts_with: ["mysql"]

# Brew (development).
brew "ack"
brew "clang-format"
brew "composer"
brew "direnv"
brew "docker-compose"
brew "git"
brew "git-lfs"
brew "hub"
brew "jq"
brew "maven"
brew "node"
brew "pv"
brew "pre-commit"
brew "python3"
brew "rbenv"
brew "redis"
brew "ripgrep"
brew "ruby-build"
brew "unixodbc" # for msodbcsql
brew "vim"
brew "yq"
#brew "denji/nginx/nginx-full", args: ["with-rmtp-module"]

# Brew (DevOps).
brew "ansible" unless system "command -v ansible"
brew "azure-cli"
brew "helm" # The Kubernetes Package Manager.
brew "kubernetes-cli"
brew "minikube"
brew "mtr"
brew "nomad"
brew "packer"
brew "terraform"

# Installs Circle CI
brew "circleci"

# Installs Drone CI.
tap "drone/drone"
brew "drone"

# Install GitHub CLI.
brew "github/gh/gh"
brew "nektos/tap/act"

# Brew (encoders).
brew "enca"
brew "encguess"
brew "uchardet"

# Brew (libraries).
brew "pcre"
brew "pcre++"
brew "openssl"

# Brew (linters/formatters).
brew "hadolint"
brew "shellcheck"
brew "shfmt"
brew "tflint"
brew "yamllint"

# Brew (cryptocurrencies).
#brew "vanitygen"

# SDL2 (game development).
#brew "sdl2"
#brew "sdl2_image"
#brew "sdl2_mixer"
#brew "sdl2_ttf"

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
cask "font-charter"
cask "hyper"
cask "iterm2"
cask "iterm2" unless system "test -d /Applications/iTerm.app"
cask "java" unless system "/usr/libexec/java_home --failfast"
cask "keepassx"
cask "reflector"
cask "sublime-text"
cask 'visual-studio-code'
cask "vagrant"
#cask "virtualbox"

# Casks (Games).
cask "openemu"
cask "steam"

# Casks (Media).
cask "vlc"
cask "mplayerx"

# Casks (Libraries).
cask "authy"
cask "flux"
cask "google-cloud-sdk"
cask "xquartz"

# Casks (Security apps).
cask 'dashlane'

# Casks (Social).
cask "google-hangouts"
cask "mplayerx"
cask "openemu"
cask "qbittorrent"
cask "skype"
cask "skype" unless system "test -d /Applications/Skype.app"
cask "slack"
cask "steam"
cask "the-unarchiver"
cask 'telegram'
cask 'zoom'

# Casks (Web browsers).
cask "brave-browser"
cask "firefox"
cask "google-chrome"
cask "opera"
