# Project Context

## Purpose

OS-nixCfg is a personal multi-platform Nix flake providing declarative, reproducible system configurations across:

- **macOS** (nix-darwin)
- **Linux** (NixOS, including WSL via NixOS-WSL)
- **Android** (nix-on-droid via Termux)
- **Standalone home-manager** configurations

The goal is to maintain consistent development environments, dotfiles, and system configurations across all devices using pure Nix expressions.

## Tech Stack

### Core Technologies

- **Nix/NixOS** - Declarative package management and system configuration
- **Nix Flakes** - Modern dependency management and reproducibility
- **flake-parts** - Modular flake organization
- **Home Manager** - User-level configuration management

### Platform-Specific

- **nix-darwin** - macOS system configuration
- **NixOS** - Linux system configuration
- **nixos-wsl** - NixOS on Windows Subsystem for Linux
- **nix-on-droid** - Android/Termux configuration

### Languages & Tooling

- **Nix Language** - Primary configuration language
- **Bash/Shell** - Utility scripts (`utils/`)
- **Lua** - Neovim, Hammerspoon, terminal emulator configs
- **Elisp** - Doom Emacs configuration

### Key Dependencies

- **Secrets Management**: agenix/ragenix for age-encrypted secrets
- **Formatters**: treefmt-nix (alejandra, deadnix, statix)
- **Pre-commit Hooks**: git-hooks.nix for automated validation
- **CI/CD**: GitHub Actions for flake checks and builds
- **Topology**: nix-topology for infrastructure visualization

## Project Conventions

### Code Style

- **Nix Formatting**: Use `nix fmt` (treefmt with alejandra) before commits
- **File Organization**: Group by capability, not by technology
- **Naming**:
  - Files: `kebab-case.nix`
  - Attributes: `camelCase` or `snake_case` following Nixpkgs conventions
  - Hosts: Single word or abbreviations (L1, M1, WSL, L2)
- **Comments**:
  - Use `#` for single-line comments
  - Use `/* */` for multi-line explanations
  - Document non-obvious decisions and workarounds

### Architecture Patterns

#### Modular Structure

- `flake.nix` - Main entry point using flake-parts
- `flake/` - Flake modules (devshells, formatters, checks, host builder)
- `hosts/` - Platform-specific host configurations (darwin/nixos/droid)
- `home/` - Home-manager modules by category (ai/dev/gui/tty/tools/web)
- `common/` - Shared configurations across platforms
- `lib/custom.nix` - Custom utility functions (e.g., `scanPaths`)
- `modules/` - Reusable NixOS/home-manager/nix-darwin modules
- `pkgs/` - Custom package derivations
- `overlays/` - Package overlays including NUR

#### Host Configuration System

- Use `flake/mkCfg.nix` universal host builder
- Four classes: `nixos`, `darwin`, `droid`, `home`
- Each host: `hosts/{platform}/{hostname}/default.nix`
- Automatic common module inclusion based on class
- Automatic tagging of successful builds with timestamps

#### Home-Manager Organization

Modules categorized by function:

- `ai/` - AI tools (Claude, OpenCode, etc.)
- `comms/` - Communication (email, IRC, newsboat)
- `dev/` - Development tools (languages, cloud tools)
- `gui/` - GUI applications and desktop managers
- `media/` - Media players and tools
- `tools/` - Utilities (privacy, productivity, AI)
- `tty/` - Terminal tools (editors, shells, multiplexers, VCS)
- `web/` - Web browsers and related tools

#### Secrets Management

- Private repo `OS-nixCfg-secrets` contains encrypted files
- Use agenix/ragenix for age encryption with SSH keys
- Secrets decrypted during build and symlinked to target locations
- **Building requires SSH access to private secrets repo**

### Testing Strategy

- **Flake Checks**: `nix flake check` validates all configurations
- **CI/CD**: GitHub Actions for:
  - `flake-check.yml` - Validate flake structure
  - `home-build.yml` - Build home-manager configs
  - `darwin-build.yml` - Build nix-darwin configs
  - `nixos-build.yml` - Build NixOS configs
  - `topology-build.yml` - Generate topology diagrams
- **Local Testing**: Use rebuild scripts in `utils/`
  - `hms` / `home_rebuild.sh` - Home-manager rebuild
  - `hts` / `hosts_rebuild.sh` - System rebuild (auto-detects OS)
- **Pre-commit Hooks**: Automatic formatting and linting

### Git Workflow

- **Main Branch**: `master` - stable configurations
- **Development**: Feature branches or direct commits for personal config
- **Commits**: Descriptive conventional-style messages
- **Pre-commit**: Automated formatting enforced
- **Secrets**: Never commit unencrypted secrets; use agenix

## Domain Context

### Multi-Platform Nix Configuration

This is a **personal configuration repository** managing multiple hosts across different operating systems. Key concepts:

- **Host Classes**: Different configuration strategies for darwin, nixos, droid, and standalone home
- **Flake Inputs**: External repositories for editor configs (Vim-Cfg, Emacs-Cfg), Firefox config, keyboard layouts (TLTR)
- **Platform-Specific Packages**: Some packages only available on certain platforms (e.g., Homebrew casks on macOS)
- **Cross-Platform Consistency**: Common modules ensure similar experience across all platforms where applicable

### External Configuration Repositories

Separate repos managed as flake inputs:

- **Vim-Cfg** - Pure Lua Neovim config
- **Emacs-Cfg** - Doom Emacs configuration
- **firefox-nixCfg** - Firefox declarative config
- **hammerspoon-nix** - macOS automation (Lua)
- **TermEmulator-Cfg** - Terminal emulator settings
- **TLTR** - Keyboard layout for programmers

## Important Constraints

### Technical Constraints

- **Nix Flakes Required**: Pure evaluation mode enforced
- **Secrets Access**: Building requires SSH key access to private `OS-nixCfg-secrets` repo
- **Platform Limitations**: Some configurations only work on specific platforms
- **Unfree Packages**: Allowed by default (`allowUnfree = true`)
- **Unstable Channel**: Primarily tracks `nixpkgs-unstable` for latest packages

### Security Constraints

- **No Plaintext Secrets**: All secrets must be encrypted with agenix
- **SSH Key Management**: Private SSH keys required for secrets decryption
- **Public Repository**: This repo is public; all sensitive data in private secrets repo

### Operational Constraints

- **Single User Focus**: Primarily configured for user `div`
- **Personal Machines**: Optimized for personal development workflow
- **macOS Primary**: Most development happens on macOS (nix-darwin)

## External Dependencies

### Essential Services

- **GitHub**: Source code hosting and CI/CD via Actions
- **Private Secrets Repo**: `github:DivitMittal/OS-nixCfg-secrets` (SSH access required)
- **Nix Binary Cache**: Default cache.nixos.org and potential custom caches

### External Configuration Sources

- **Vim-Cfg** - `github:DivitMittal/Vim-Cfg`
- **Emacs-Cfg** - `github:DivitMittal/Emacs-Cfg`
- **firefox-nixCfg** - `github:DivitMittal/firefox-nixCfg`
- **hammerspoon-nix** - `github:DivitMittal/hammerspoon-nix`
- **TermEmulator-Cfg** - `github:DivitMittal/TermEmulator-Cfg`
- **TLTR** - `github:DivitMittal/TLTR`

### Key Flake Inputs (see flake.nix)

- **nixpkgs** family (unstable, master, darwin, nixos branches)
- **NUR** (Nix User Repository)
- **Platform integrations** (nix-darwin, nixos-wsl, nix-on-droid)
- **Tooling** (home-manager, agenix, ragenix, nix-topology)
- **Editor support** (nvchad4nix, nix-doom-emacs-unstraightened)

### Development Tools

- **Pre-commit**: Code quality checks
- **treefmt**: Multi-formatter (alejandra, deadnix, statix)
- **direnv**: Automatic environment loading
- **nix-index-database**: Fast package search
