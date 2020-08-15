# Bundler file for non-Ruby dependencies from Homebrew.
# Usage: ACCEPT_EULA=y brew bundle install -v
# @docs https://github.com/Homebrew/homebrew-bundle#usage

# Taps.
tap 'microsoft/mssql-release', 'https://github.com/Microsoft/homebrew-mssql-release'

# Brew (CLI).
brew "afsctool"
brew "asciinema"
brew "bash"
brew "bash-completion"
brew "curl"
brew "curl-openssl"
brew "fd"
brew "fdupes"
brew "graphviz"
brew "imagemagick"
brew "mackup"
brew "rename"
brew "telnet"
brew "transmission"
brew "tree"
brew "wget"
brew "ydiff"
brew "youtube-dl"

# Brew (Crypto).
brew "geth"
brew "hsd"

# Brew (Extract tools).
brew "cabextract"
brew "gzip"
brew "p7zip"
brew "unrar"

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
brew "screen"
brew "watch"
brew "wdiff"

# Brew (databases).
tap "mongodb/brew"
brew "h2"
brew "mongodb-community"
brew "mysql-client"
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
brew "gcc"
brew "git"
brew "git-lfs"
brew "groovy"
brew "hub"
brew "jinja2-cli"
brew "jq"
brew "maven"
brew "node"
brew "pev"
brew "pre-commit"
brew "pv"
brew "python3"
brew "rbenv"
brew "redis"
brew "ripgrep"
brew "ruby-build"
brew "rust"
brew "subversion"
brew "unixodbc" # for msodbcsql
brew "vim"
brew "yq"
#brew "denji/nginx/nginx-full", args: ["with-rmtp-module"]

# Brew (DevOps).
brew "ansible" unless system "command -v ansible"
brew "arping"
brew "awscli"
brew "azure-cli"
brew "helm" # The Kubernetes Package Manager.
brew "kubernetes-cli"
brew "minikube"
brew "mtr"
brew "nomad"
brew "packer"
brew "terraform"

# Brew (media).
brew "ffmpeg"
brew "libav"

# Brew (security).
brew "hashcat"

# Installs Circle CI
brew "circleci"

# Installs Drone CI.
tap "drone/drone"
brew "drone"

# Installs GitHub CLI utilities.
tap "github/gh"
tap "nektos/tap"
brew "act"
brew "gh"

# Brew (encoders).
brew "enca"
brew "uchardet"

# Brew (libraries).
brew "pcre"
brew "pcre++"
brew "openssl"

# Brew (linters/formatters).
brew "dos2unix"
brew "hadolint"
brew "html2text"
brew "jsonlint"
brew "prettier"
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

# Installs Jenkins X (JX).
tap "jenkins-x/jx"
brew "jx"

# Installs MicroK8s.
# https://www.techrepublic.com/article/how-to-install-microk8s-on-macos/
tap "ubuntu/microk8s"
brew "microk8s"

# Casks (Setup).
tap "homebrew/cask"
tap "homebrew/cask-versions"
cask_args appdir: "/Applications"

# Casks (Libs).
cask "osxfuse"
cask "xquartz"

# Casks (Apps).
cask "adobe-acrobat-reader"
cask "alfred"
cask "balsamiq-wireframes"
cask "bartender"
cask "caffeine"
cask "dbeaver-community"
#cask "deepl"
cask "docker"
cask "dropbox"
cask "evernote"
cask "jollysfastvnc"
cask "libreoffice"
cask "keka"
cask "keybase"
cask "kindle"
cask "kubernetic"
cask "qbittorrent"
cask "sonic-pi"
cask "the-unarchiver"
cask "tigervnc-viewer"
cask "turbovnc-viewer"
cask "vnc-viewer"
cask "webtorrent"
#cask "wine-devel" # @fixme: Broken: Bad CPU type

# Casks (development).
cask "adoptopenjdk"
cask "android-file-transfer"
cask "ccmenu"
cask "charles"
cask "dash"
cask "diffmerge"
cask "dropbox"
cask "evernote"
cask "hyper"
cask "iterm2"
cask "iterm2" unless system "test -d /Applications/iTerm.app"
cask "java" unless system "/usr/libexec/java_home --failfast"
cask "keepassx"
cask "meld"
cask "powershell"
cask "reflector"
cask "sublime-text"
cask 'visual-studio-code'
cask "vagrant"
#cask "virtualbox"

# Casks (Games).
cask "openemu"
cask "steam"

# Casks (Media).
cask "mplayerx"
cask "spotify"
cask "vlc"

# Casks (Libraries).
cask "authy"
cask "flux"
cask "google-cloud-sdk"

# Casks (Security apps).
cask 'dashlane'
cask 'gpg'

# Casks (Social).
cask "google-hangouts"
cask "mplayerx"
cask "openemu"
cask "qbittorrent"
cask "skype"
cask "skype" unless system "test -d /Applications/Skype.app"
cask "slack" unless system "test -d /Applications/Slack.app"
cask "steam"
cask "the-unarchiver"
cask 'telegram'
cask 'zoom'

# Casks (Web browsers).
cask "brave-browser"
cask "firefox"
cask "google-chrome" unless system "test -d '/Applications/Google Chrome.app'"
cask "opera"
