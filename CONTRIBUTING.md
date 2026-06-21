# Contributing

Contributions are welcome — bug reports, fixes, and improvements to the Nix configurations.

## Setup

```sh
nix develop   # enter dev shell (nixd, alejandra, statix, deadnix)
```

## Guidelines

- **Nix files**: format with `alejandra` (enforced by pre-commit)
- Run `nix flake check` before submitting — CI runs the same check
- Test changes on the relevant platform (darwin/NixOS/WSL) before submitting
- Keep changes focused — avoid mixing platform-specific changes with shared modules

## Submitting Changes

1. Fork the repo and create a branch: `feat/description` or `fix/description`
2. Keep commits atomic; use [Conventional Commits](https://www.conventionalcommits.org/) format
3. Open a PR against `main` with a clear description of what and why

## Reporting Issues

Open a GitHub issue with:

- Your platform (darwin/NixOS/WSL), nixpkgs channel, and system architecture
- Steps to reproduce
- Expected vs actual behavior
