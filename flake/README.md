# Flake Directory

This directory contains flake-parts modules that define various aspects of the flake configuration.

## Overview

Using flake-parts modular structure, each file in this directory defines specific flake outputs:

- **devshells.nix** - Development shell configurations with tools and utilities
- **formatters.nix** - Code formatting configuration (treefmt with alejandra, deadnix, statix)
- **checks.nix** - Pre-commit hooks and CI checks
- **mkHost.nix** - Universal host builder function supporting multiple platforms
- **topology.nix** - nix-topology integration for infrastructure visualization
- **actions/** - GitHub Actions workflow definitions

## File Descriptions

### devshells.nix

Defines the development environment with:

- Nix tooling (nixfmt, statix, deadnix)
- Build scripts (hms, hts, etc.)
- Git utilities
- Documentation tools

Access with: `nix develop` or `nix-shell`

### formatters.nix

Configures treefmt with:

- **alejandra** - Nix code formatter
- **deadnix** - Dead code elimination
- **statix** - Linting for Nix

Usage: `nix fmt`

### checks.nix

Sets up pre-commit hooks for:

- Code formatting
- Linting
- Build verification

Automatically runs before commits.

### mkHost.nix

Universal host builder supporting:

- **nixos** - NixOS systems
- **darwin** - macOS systems (nix-darwin)
- **droid** - Android systems (nix-on-droid)
- **home** - Standalone home-manager

Example usage in `hosts/`:

```nix
mkHost {
  class = "nixos";
  hostName = "myhost";
  system = "x86_64-linux";
  additionalModules = [ ... ];
}
```

### topology.nix

Integrates nix-topology for infrastructure visualization:

- Automatically discovers NixOS configurations
- Generates SVG diagrams of your infrastructure
- Must be built on Linux systems

See `../topology/README.md` for details.

### actions/

Contains GitHub Actions workflow definitions for CI/CD:

- Automated builds
- Checks and testing
- Deployment automation

## Adding New Flake Modules

To add a new flake-parts module:

1. Create a new `.nix` file in this directory
2. Use the flake-parts module structure:
   ```nix
   {inputs, ...}: {
     perSystem = {pkgs, system, ...}: {
       # Your configuration here
     };
   }
   ```
3. The module is automatically imported via `scanPaths` in `default.nix`

## Related Documentation

- Root README.md - Overall project structure
- CLAUDE.md - Development commands and workflow
- ../topology/README.md - Topology visualization
