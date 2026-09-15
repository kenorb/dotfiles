# AGENTS.md

Persistent single-source truth for autonomous agent behavior in the `etc/` directory.

## Scope

`etc/` mirrors system configuration that belongs under `/etc`. Files are symlinked into `/etc`
rather than copied, so editing a file here changes the host configuration as soon as the matching
reload command runs.

## Layout

| Path | Deployed to | Apply with |
| --- | --- | --- |
| `docker/daemon.json` | `/etc/docker/daemon.json` | `sudo systemctl restart docker` |
| `logrotate.conf` | `/etc/logrotate.conf` | (logrotate cron) |
| `security/limits.d/*.conf` | `/etc/security/limits.d/` | re-login |
| `ssl/openssl.cnf` | `/etc/ssl/openssl.cnf` | (per-consumer) |
| `sysctl.d/*.conf` | `/etc/sysctl.d/` | `sudo sysctl --system` |

## Docker: default bridge loses its gateway address

### Symptom

Containers on the default `bridge` network have no outbound network and no DNS. A dev container
`RUN` step, a Molecule run, or `docker run ... apk update` fails to reach the network, while the
host itself resolves and routes fine.

### Root cause

`docker0`'s address no longer matches the `bridge` network's configured gateway, so containers are
handed a default route pointing at an address that is not present on the bridge.

### Check

```bash
ip -4 addr show docker0
docker network inspect bridge --format '{{range .IPAM.Config}}{{.Subnet}} {{.Gateway}}{{end}}'
```

If the gateway printed by the second command is missing from the first, the bridge is broken.

### Why it happens

`/etc/docker/daemon.json` did not pin `bip`, so the default bridge subnet was implicit and stored
in `/var/lib/docker/network/files/local-kv.db`. When that stored subnet and `docker0`'s actual
address drift apart, containers get an unreachable gateway. NetworkManager also manages `docker0`
on this host and can flush addresses from it.

### Fix

`docker/daemon.json` pins the bridge explicitly:

```json
{
    "bip": "172.17.0.1/16",
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    }
}
```

`bip` defines both `docker0`'s address and the default `bridge` network's subnet, so the two can no
longer disagree. The `runtimes` block is required by the NVIDIA container toolkit - keep it when
editing this file.

### Apply

```bash
sudo ln -sfn ~/dotfiles/etc/docker/daemon.json /etc/docker/daemon.json
sudo systemctl restart docker
```

The restart kills running containers, including an in-flight Molecule run.

### Verify

```bash
ip -4 addr show docker0
docker network inspect bridge --format '{{range .IPAM.Config}}{{.Subnet}} {{.Gateway}}{{end}}'
docker run --rm alpine:3.20 sh -c 'ip route; getent hosts deb.debian.org'
```

The gateway from the second command must appear on `docker0` in the first, and the third command
must resolve a name. Re-run after a reboot to confirm the address returns without manual steps.

### Fallback: stale network store

If `docker network inspect bridge` still reports a subnet other than `bip` after the restart, the
stored network database is stale. Recreate it from the daemon config:

```bash
sudo systemctl stop docker
sudo rm -f /var/lib/docker/network/files/local-kv.db
sudo systemctl start docker
```

This drops user-defined networks (they must be recreated); the default `bridge` is rebuilt from
`bip`.

### Hardening: keep NetworkManager off docker0

NetworkManager is active on this host and lists `docker0`. Mark it unmanaged so it cannot flush the
bridge address.

`/etc/NetworkManager/conf.d/99-docker0-unmanaged.conf`

```ini
[keyfile]
unmanaged-devices=interface-name:docker0
```

```bash
sudo systemctl reload NetworkManager
nmcli device status   # docker0 should read "unmanaged"
```

### Not a fix

`sudo ip addr add 172.17.0.1/16 dev docker0` restores connectivity immediately but is runtime-only:
Docker flushes and re-adds `docker0`'s addresses on every daemon start, and a reboot drops it.

## Agent Directives

- **MUST** keep the `runtimes.nvidia` block in `docker/daemon.json`; dropping it disables the
  NVIDIA container runtime.
- **MUST** keep JSON keys in lexical order in `docker/daemon.json`.
- **MUST NOT** commit secrets into this directory; it is symlinked into `/etc`.
