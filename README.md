<div id="top">
    <div align="center">
        <img alt='An abstract image of a donut-like object' title='Qezta' height='250' src='./assets/qezta.png' style="position: relative; top: 0; right: 0;" />
        <h1 align='center'>OS-nixCfg</h1>
        <strong>My personal declarative Nix configurations for macOS, Android, and Linux (NixOS/WSL).</strong>
    </div>
</div>

---

<div align='center'>
    <p></p>
    <div align="center">
        <!-- GitHub Badges -->
        <a href="https://github.com/DivitMittal/OS-nixCfg/stargazers">
            <img src="https://img.shields.io/github/stars/DivitMittal/OS-nixCfg?&style=for-the-badge&logo=starship&logoColor=white&color=purple" alt="stars"/>
        </a>
        <a href="https://github.com/DivitMittal/OS-nixCfg/">
            <img src="https://img.shields.io/github/repo-size/DivitMittal/OS-nixCfg?&style=for-the-badge&logo=github&logoColor=white&color=purple" alt="size" />
        </a>
        <a href="https://github.com/DivitMittal/OS-nixCfg/blob/main/LICENSE">
            <img src="https://img.shields.io/github/license/DivitMittal/OS-nixCfg?&style=for-the-badge&logo=unlicense&logoColor=white&color=purple" alt="license"/>
        </a>
         <a href="https://github.com/nixos/nixpkgs">
            <img src="https://img.shields.io/badge/Nixpkgs-unstable-blue.svg?style=for-the-badge&logo=NixOS&logoColor=white&color=purple" alt="nixpkgs"/>
        </a>
        <img src="https://img.shields.io/github/languages/top/DivitMittal/OS-nixCfg?style=for-the-badge&color=purple" alt="repo-top-language">
        <img src="https://img.shields.io/github/languages/count/DivitMittal/OS-nixCfg?style=for-the-badge&color=purple" alt="repo-language-count">
    </div>
    <br>
</div>

---

## 📜 Overview

This repository contains primarily [nix](https://github.com/nixos/nix) configurations, leveraging [Nix Flakes](https://nixos.wiki/wiki/Flakes), [Home Manager](https://github.com/nix-community/home-manager), and system-specific modules ([NixOS](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin), [nix-on-droid](https://github.com/nix-community/nix-on-droid)) to achieve a purely declarative, reproducible, and consistent environment across multiple OSes on multiple hosts for multiple users:

- 🍎 **macOS** (via `nix-darwin`)
- 🤖 **Android** (via `nix-on-droid`)
- 🐧 **\*nix (NixOS)** (including WSL via `NixOS-WSL`)

## 📁 Project Structure

The repository is organized using [flake-parts](https://github.com/hercules-ci/flake-parts) for better modularity.

```
└── OS-nixCfg/
    ├── flake.nix             # Entry point: Defines inputs, outputs, modules imports, mkHosts
    ├── flake.lock            # Lockfile for reproducible dependencies
    ├── README.md             # This file
    ├── LICENSE               # MIT License
    ├── nix.nix               # Common Nix settings (package, experimental features)
    ├── devShell.nix          # Defines devShell with helper commands (hts, hms, etc.)
    ├── checks.nix            # Defines pre-commit checks
    ├── shell.nix             # Basic shell for bootstrapping
    ├── assets/               # Images and other static assets
    ├── lib/                  # Custom Nix helper functions (e.g., scanPaths)
    ├── modules/              # Custom modules for flake-parts, home-manager, nix-darwin, nixos
    │   ├── common/           # Modules shared across all systems/users
    │   ├── home/             # Home Manager modules (e.g., aichat, spicetify)
    │   └── hosts/            # System-specific modules (e.g., kanata services for darwin)
    ├── home/                 # Home Manager configurations, organized by category
    │   ├── default.nix       # Defines homeConfigurations for different users/hosts
    │   ├── common/           # Base settings for all home-manager users
    │   ├── age.nix           # Agenix secrets configuration for home-manager
    │   ├── comms/            # Communication tools (email, irc, discord, etc.)
    │   ├── desktop-env/      # Desktop environment settings (terminal, macOS specifics)
    │   ├── dev/              # Development tools and languages
    │   ├── keyboard/         # Keyboard remapping (Kanata, Karabiner - disabled)
    │   ├── media/            # Media applications (mpv, spotify)
    │   ├── tools/            # General utilities (AI, network, privacy, virt)
    │   ├── tty/              # Terminal-specific tools (editors, shells, vcs, etc.)
    │   └── web/              # Web browser configurations (Firefox, Chromium - disabled)
    ├── hosts/                # System configurations (NixOS, nix-darwin, nix-on-droid)
    │   ├── default.nix       # Defines system configurations (darwinConfigurations, nixosConfigurations)
    │   ├── common/           # Base settings shared across nixos & nix-darwin
    │   ├── darwin/           # macOS specific configurations via nix-darwin
    │   │   ├── common/       # Settings common to all macOS hosts
    │   │   ├── L1/           # Host-specific configuration for 'L1' (apps, services, defaults)
    │   │   └── etc/          # macOS specific static config files (e.g., rEFInd)
    │   ├── droid/            # Android specific configurations via nix-on-droid
    │   │   ├── common/       # Settings common to all Android hosts
    │   │   └── M1/           # Host-specific configuration for 'M1'
    │   └── nixOS/            # NixOS specific configurations
    │       ├── common/       # Settings common to all NixOS hosts
    │       ├── L2/           # Host-specific configuration for 'L2'
    │       └── WSL/          # Host-specific configuration for 'WSL'
    └── scripts/              # Helper scripts for applying configurations
        ├── home_rebuild.sh   # Applies home-manager configuration
        └── hosts_rebuild.sh  # Applies system configuration (darwin, nixos, droid)
```

## ❄️Flake Inputs

This flake relies on several external inputs to manage dependencies and configurations:

- **`nixpkgs`**: The core Nix package set (tracking `nixpkgs-unstable`).
- **`flake-parts`**: Used for structuring the flake outputs with modularity.
- **`home-manager`**: Manages user-level configurations and dotfiles.
- **`nix-darwin`**: Enables declarative macOS system configuration.
- **`nix-on-droid`**: Enables declarative Android configuration via Termux fork.
- **`NixOS-WSL`**: Provides modules for running NixOS on WSL.
- **`nix-homebrew`**: For Homebrew bootstrapping within `nix-darwin`.
- **`agenix` / `ragenix`**: Used for managing secrets declaratively via age encryption.
- **`OS-nixCfg-secrets`**: **(Private Repository)** Contains encrypted secrets managed by `agenix`.
- **`Nvim-Cfg`**: My external Neovim configuration repository.
- **`nvchad4nix`**: Integrates Neovim configurations (like NvChad or custom starters) with Home Manager.
- **`kanata-tray`**: Provides a system tray application for managing Kanata keyboard remapping presets.
- **`devshell`**: Provides a convenient development shell
- **`pre-commit-hooks`**: Manages Git hooks for code quality and formatting.
- **`systems`**: Provides standard system identifiers list (e.g., `x86_64-darwin`).
- **(Other dependencies)**: Various helper flakes and libraries.

_(See `flake.nix` for the complete list and specific sources)_

## 🔒 Secrets Management

Secrets (API keys, passwords, sensitive configurations) are managed using [agenix](https://github.com/ryantm/agenix) or specificaly [ragenix](https://github.com/yaxitech/ragenix).

1.  Secrets are encrypted using `ssh` keys. My public key is explicitly available to `ragenix`.
2.  The encrypted files reside in a **private** GitHub repository: `DivitMittal/OS-nixCfg-secrets`. This repository is referenced as a flake input.
3.  During the Nix build process, `agenix` decrypts these files using my private key (which must be present on the target machine at `~/.ssh/agenix/id_ed25519`).
4.  The decrypted files are placed in the Nix store and symlinked to their target locations.

⚠️ **Building this configuration requires access to the private `OS-nixCfg-secrets` repository and the corresponding private `ssh` key.**

## 🔗 Related Repositories

- [DivitMittal/Nvim-Cfg](https://github.com/DivitMittal/Nvim-Cfg): Pure lua standalone Neovim configuration, used as an input via `nix4nvchad`.
- `DivitMittal/OS-nixCfg-secrets`: (Private) Contains encrypted secrets managed by `agenix`.
- [DivitMittal/TLTR](https://github.com/DivitMittal/TLTR): Cross-platform complex multi-layer keyboard layout tailored for programmers .

<div align="right">

[![][back-to-top]](#top)

</div>

[back-to-top]: https://img.shields.io/badge/-BACK_TO_TOP-151515?style=flat-square&color=purple
