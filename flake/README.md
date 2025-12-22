# Flake Directory

Flake-parts modules defining flake outputs.

## Contents

- **devshells.nix** - Development environment (`nix develop`)
- **formatters.nix** - Code formatting (`nix fmt`: alejandra, deadnix, statix)
- **checks.nix** - Pre-commit hooks
- **mkCfg.nix** - Universal host builder (nixos/darwin/droid/home)
- **iso-packages.nix** - ISO build packages
- **topology/** - Infrastructure visualization (nix-topology)
  - default.nix - Topology module exports
  - global.nix - Global topology definitions
- **actions/** - GitHub Actions workflows
  - default.nix - Actions module exports
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
