# dotfiles

Various configuration files.

## Installation

Clone repository into your HOME dir, then execute in the repo folder:

### Ansible Setup

Follow steps from: [`./ansible/README.md`](./ansible/README.md)

## Development

### Devcontainer

The repository includes `.devcontainer/devcontainer.json` for a reproducible local
setup with GitHub Actions tooling, Docker support, and common CLI dependencies.

### pre-commit

Run repository-wide validation before opening a pull request:

```bash
pre-commit run -a
```

## Troubleshooting

If you get the following error while loading *rc* files:

> syntax error near unexpected token `&'

you need to upgrade your `bash` by the following steps:

1. `brew install bash`
1. `sudo ex +'$put =\"/usr/local/bin/bash\"' -scwq /etc/shells`
1. `chsh -s /usr/local/bin/bash`