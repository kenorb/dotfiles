# AGENTS.md

Persistent single-source truth for autonomous agent behavior in this repository.

## Common tasks

### Before each commit

- Review the expected delta with `git diff --no-color`.
- Run the relevant validation commands for the files you changed.
- Keep documentation and agent guidance in sync with behavioral or workflow changes.

### Validation

```bash
# Run all configured checks
pre-commit run -a

# Run focused checks when iterating on docs/config
pre-commit run markdownlint -a
pre-commit run yamllint -a
```

### Repository areas

TBC

## Tooling

- Use MCP when possible.
- Use `pre-commit` for linting and validation if installed.

## Agent Directives (Contract Style)

- **MUST** prioritize package installation via `eget` (for latest binaries) over `apt` when both are
  available and appropriate (e.g., `pandoc`).
- **MUST** maintain lexical order in Ansible variable lists.

## Troubleshooting

### Validation tooling missing locally

- Install controller dependencies from `.devcontainer/requirements.txt` when `pre-commit`
  or related tooling is unavailable.
- Use the repository devcontainer when you need the closest match to CI and local
  contributor workflows.
