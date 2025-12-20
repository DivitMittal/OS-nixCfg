# Flake Directory

Flake-parts modules defining flake outputs.

## Contents

- **devshells.nix** - Development environment (`nix develop`)
- **formatters.nix** - Code formatting (`nix fmt`: alejandra, deadnix, statix)
- **checks.nix** - Pre-commit hooks
- **mkHost.nix** - Universal host builder (nixos/darwin/droid/home)
- **topology/** - Infrastructure visualization (nix-topology)
  - global.nix - Global topology definitions
- **actions/** - GitHub Actions workflows
  - darwin-build.nix - macOS build actions
  - flake-check.nix - Flake validation
  - flake-lock-update.nix - Dependency updates
  - home-build.nix - Home-manager builds
  - nixos-build.nix - NixOS build actions
  - topology-build.nix - Topology generation

## Adding Modules

Create `.nix` file using flake-parts structure:

```nix
{inputs, ...}: {
  perSystem = {pkgs, system, ...}: {
    # Configuration
  };
}
```

Auto-imported via `scanPaths`.
