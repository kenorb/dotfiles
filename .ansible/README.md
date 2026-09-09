# Ansible Playbooks

These playbooks are used to set up and configure your Linux environment autonomously.

## Requirements

- `pipenv`
  Install by: `sudo apt --yes install pipenv`
- `ansible` (installed via Pipenv)

## Usage

Before running the playbook, ensure you have your `variables.yml` set up:

```bash
cp variables-example.yml variables.yml # Modify after copy.
```

Run the setup playbook:

```bash
pipenv sync
pipenv run ansible-galaxy install -r requirements.yml
pipenv run ansible-playbook -i inventory/hosts playbooks/setup-linux.yml -K
```

## Available Tags

You can use tags to run specific parts of the playbook using the `--tags` flag.

| Tag | Description |
| --- | --- |
| `apt` | Runs all APT related tasks (upgrade, install, releases). |
| `brave` | Installs Brave Browser. |
| `cuda` | Specific tasks for CUDA Toolkit. |
| `dotfiles` | Manages symlinks for dotfiles in your home directory. |
| `eget` | Installs `eget` and configured binary packages. |
| `ethereum` | Installs Ethereum tools from the official Ethereum PPA. |
| `install` | Installs the list of packages defined in `apt.install` and `eget` packages. |
| `nvidia` | Handles NVIDIA/CUDA related installations. |
| `protonvpn` | Installs Proton VPN app from the official Proton APT repository. |
| `upgrade` | Performs `apt upgrade` and updates `eget` packages. |
| `vpn` | Runs VPN related tasks. |
| `vscode` | Installs Visual Studio Code. |

Example:

```bash
# Run only dotfiles symlinking
pipenv run ansible-playbook -i inventory/hosts playbooks/setup-linux.yml -K --tags dotfiles
```

## Tasks Overview

The `setup-linux.yml` playbook performs the following operations:

1. **Apt Upgrade**: Updates system packages to their latest versions.
2. **Apt Install**: Installs a core set of CLI tools and libraries.
3. **CUDA Toolkit**: Configures and installs NVIDIA CUDA drivers and toolkit.
4. **VS Code**: Adds the Microsoft repository and installs Visual Studio Code.
5. **Brave Browser**: Adds the Brave repository and installs the browser.
6. **Proton VPN**: Adds the official Proton VPN repository and installs the GUI app.
7. **Ethereum**: Adds the official Ethereum PPA and installs the `ethereum` package.
8. **Eget**: Installs the `eget` binary and a set of useful CLI tools to `~/.local/bin`.
9. **Dotfiles**: Symlinks configuration files from this repository into your `$HOME`.

### Note on Dotfiles Conflicts

If a regular file or directory already exists in your home directory (e.g., an existing `.bashrc` that is not a symlink),
the playbook will **not** overwrite it. Instead:

- It will output a warning message.
- It will create a symlink with a `.new` extension (e.g., `~/.bashrc.new`) pointing to the version in this repository.

This allows you to compare the two versions and manually merge or replace your existing files with the ones from the repository.
