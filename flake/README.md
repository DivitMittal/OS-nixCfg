# Flake Directory

Flake-parts modules defining flake outputs.

## Contents

- **devshells.nix** - Development environment (`nix develop`)
- **formatters.nix** - Code formatting (`nix fmt`: alejandra, deadnix, statix)
- **checks.nix** - Pre-commit hooks
- **mkHost.nix** - Universal host builder (nixos/darwin/droid/home)
- **topology.nix** - Infrastructure visualization (nix-topology)
- **actions/** - GitHub Actions workflows

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
