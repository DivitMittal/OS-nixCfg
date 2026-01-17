## Development Commands

**Entry point**: Use `nix develop` or `nix-shell` to enter development environment with all tools.

**Key rebuild commands** (available in devshell):

- `hms [flags]` - Rebuild & switch home-manager configuration (accepts flags like `-v`, `--show-trace`, `--impure`)
- `hts [flags]` - Rebuild & switch host configuration (nix-darwin/nixos/nix-on-droid, accepts flags)

**Direct script usage**:

- `./utils/home_rebuild.sh [flags]` - Rebuild home-manager config (pass flags as arguments)
- `./utils/hosts_rebuild.sh [flags]` - Rebuild system config (pass flags as arguments)

**Example usage**:

```bash
# With verbose output and trace
hms -v --show-trace

# For debugging impure builds (if needed)
hms --impure --show-trace
```

**Formatting & Linting**:

- `nix fmt` - Format all nix files using treefmt (alejandra, deadnix, statix)
- Pre-commit hooks are set up to run formatting automatically

**Build & Check**:

- `nix flake check` - Verify flake configuration
- Individual configs can be built without switching using `nix build`

## Architecture Overview

This is a **multi-platform Nix flake** supporting macOS (nix-darwin), Linux (NixOS), Android (nix-on-droid), and standalone home-manager configs.

**Core Structure**:

- `flake.nix` - Main flake entry point using flake-parts for modular organization
- `flake/` - Flake module definitions (devshells, formatters, checks, host builder)
- `hosts/` - Platform-specific host configurations (darwin/nixos/droid)
- `home/` - Home-manager modules organized by category (dev/gui/tty/tools/etc)
- `common/` - Shared configurations across all platforms
- `lib/custom.nix` - Custom utility functions like `scanPaths`

**Host Configuration System**:

- `flake/mkCfg.nix` defines a universal host builder function
- Supports 4 classes: `nixos`, `darwin`, `droid`, `home`
- Automatically includes appropriate common modules based on class
- Each host gets its own directory under `hosts/{platform}/{hostname}/`

**Home-Manager Organization**:
Home modules are categorized by function:

- `comms/` - Communication (email, IRC, newsboat)
- `dev/` - Development tools (JS, Python, cloud)
- `gui/` - GUI applications and desktop managers
- `tty/` - Terminal tools (editors, shells, multiplexers, VCS)
- `tools/` - Utilities (AI tools, privacy, productivity)
- `web/` - Web browsers and related tools

**Secrets Management**:

- Uses agenix/ragenix for encrypted secrets
- Private repo `OS-nixCfg-secrets` contains encrypted files
- Requires SSH key access to build configurations with secrets

**Custom Packages**:

- `pkgs/` contains custom derivations, organized by platform
- `overlays/` provides package overlays including NUR integration

**Key Dependencies**:

- Core: nixpkgs-unstable, home-manager, flake-parts
- Platform: nix-darwin, nixos-wsl, nix-on-droid
- External configs: Vim-Cfg, Emacs-Cfg, firefox-nixCfg (separate repos)
- Tools: hammerspoon-nix, kanata-tray, yazi-plugins

## Important Notes

- Repository uses `flake-parts` for modular flake organization
- All platforms share common configurations where possible
- Host-specific configs live in `hosts/{platform}/{hostname}/`
- Development environment provides consistent tooling across platforms
- Automatic tagging of successful builds with timestamps
- Pre-commit hooks enforce code formatting and quality
