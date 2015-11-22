# dotfiles

Various configuration files.

## Installation

Clone repository into your HOME dir, then execute:

    make install

### Troubleshooting

If you get the following error while loading *rc* files:

> syntax error near unexpected token `&'

you need to upgrade your `bash` by the following steps:

1. `brew install bash`
1. `sudo ex +'$put =\"/usr/local/bin/bash\"' -scwq /etc/shells`
1. `chsh -s /usr/local/bin/bash`
