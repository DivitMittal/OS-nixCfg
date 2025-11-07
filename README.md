<div id="top">
    <div align="center">
        <img alt='An abstract image of a donut-like object' title='Qezta' height=250 width=250 src='./assets/qezta.gif' style="position: relative; top: 0; right: 0;" />
        <h1 align='center'>OS-nixCfg</h1>
        <strong>My personal declarative Nix configurations for macOS, Android, and Linux (NixOS/WSL).</strong>
    </div>

</div>

---

<div align='center'>
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
    <img src="https://img.shields.io/github/languages/top/DivitMittal/OS-nixCfg?style=for-the-badge&color=purple" alt="repo-top-language"/>
</div>

---

<div align='center'>
    <a href="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/flake-check.yml">
        <img src="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/.github/workflows/flake-check.yml/badge.svg" alt="nix-flake-check"/>
    </a>
    <a href="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/home-build.yml">
        <img src="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/.github/workflows/home-build.yml/badge.svg" alt="home-manager-build"/>
    </a>
    <a href="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/darwin-build.yml">
        <img src="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/.github/workflows/darwin-build.yml/badge.svg" alt="nix-darwin-build"/>
    </a>
    <a href="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/nixos-build.yml">
        <img src="https://github.com/DivitMittal/OS-nixCfg/actions/workflows/.github/workflows/nixos-build.yml/badge.svg" alt="nixos-build"/>
    </a>
</div>

---

## Contents

- [📜 Overview](#-overview)
- [📁 Project Structure](#-project-structure)
- [📊 Home Manager Profile Graph](#-home-manager-profile-graph)
- [🗺️ Network Topology](#️-network-topology)
- [❄️Flake Inputs](#flake-inputs)
- [🔒 Secrets Management](#-secrets-management)
- [🔗 Related Repositories](#-related-repositories)

---

## 📜 Overview

This repository contains primarily [nix](https://github.com/nixos/nix) configurations, leveraging [Nix Flakes](https://nixos.wiki/wiki/Flakes), [Home Manager](https://github.com/nix-community/home-manager), and system-specific modules ([NixOS](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin), [nix-on-droid](https://github.com/nix-community/nix-on-droid)) to achieve a purely declarative, reproducible, and consistent environment across multiple OSes on multiple hosts for multiple users:

- 🍎 **macOS** (via `nix-darwin`)
- 🤖 **Android** (via `nix-on-droid`)
- 🐧 **\*nix (NixOS)** (including WSL via `NixOS-WSL`)

## 📁 Project Structure

The repository is organized using [flake-parts](https://github.com/hercules-ci/flake-parts) for better modularity.

```
├── .claude/
│   └── settings.json
├── .github/
│   ├── workflows/
│   │   ├── darwin-build.yml
│   │   ├── flake-check.yml
│   │   ├── flake-lock-update.yml
│   │   ├── flakehub-publish-tagged.yml
│   │   ├── home-build.yml
│   │   ├── nixos-build.yml
│   │   └── topology-build.yml
│   └── FUNDING.yml
├── assets/
│   ├── topology/
│   │   ├── main.svg
│   │   └── network.svg
│   ├── home_graph.png
│   ├── qezta.gif
│   └── qezta.png
├── common/
│   ├── all/
│   ├── home/
│   └── hosts/
│       ├── all/
│       ├── darwin/
│       ├── droid/
│       └── nixos/
├── flake/
│   ├── actions/
│   ├── topology/
│   ├── checks.nix
│   ├── default.nix
│   ├── devshells.nix
│   ├── formatters.nix
│   └── mkHost.nix
├── home/
│   ├── ai/
│   │   └── interface/
│   ├── comms/
│   │   ├── email/
│   │   └── irc/
│   ├── dev/
│   │   ├── js/
│   │   └── python/
│   ├── gui/
│   │   ├── darwin/
│   │   ├── emulators/
│   │   ├── ide/
│   │   └── linux/
│   ├── media/
│   │   └── music/
│   ├── tools/
│   │   ├── keyboard/
│   │   ├── privacy/
│   │   └── productivity/
│   ├── tty/
│   │   ├── editors/
│   │   ├── fetchers/
│   │   ├── file/
│   │   ├── multiplexers/
│   │   ├── network/
│   │   ├── pagers/
│   │   ├── shells/
│   │   └── vcs/
│   ├── web/
│   │   └── tui/
│   └── default.nix
├── hosts/
│   ├── darwin/
│   │   └── L1/
│   ├── droid/
│   │   └── M1/
│   ├── nixos/
│   │   ├── L2/
│   │   └── WSL/
│   └── default.nix
├── lib/
│   ├── custom.nix
│   └── default.nix
├── modules/
│   ├── home/
│   ├── hosts/
│   │   └── darwin/
│   └── default.nix
├── overlays/
│   ├── default.nix
│   └── nixpkgs.nix
├── pkgs/
│   ├── custom/
│   │   ├── gittype-bin/
│   │   └── gowa/
│   ├── darwin/
│   │   ├── cliclick-bin/
│   │   ├── element/
│   │   ├── hot-bin/
│   │   ├── LibreScore-bin/
│   │   ├── LosslessSwitcher-bin/
│   │   ├── menubar-dock-bin/
│   │   ├── MultiSoundChanger-bin/
│   │   └── wacom-toggle/
│   └── pypi/
│       ├── flatlatex/
│       └── keymap-drawer/
├── templates/
│   ├── vanilla/
│   │   └── flake/
│   └── default.nix
├── utils/
│   ├── home_rebuild.sh
│   └── hosts_rebuild.sh
├── .editorconfig
├── .envrc
├── .gitattributes
├── .gitignore
├── .mcp.json
├── CLAUDE.md
├── CODEOWNERS
├── flake.lock
├── flake.nix
├── LICENSE
├── README.md
├── SECURITY.md
└── shell.nix
```

## 📊 Home-Manager Profile Graph

This dependency graph visualizes the dependencies of the Home-Manager profile configuration:

![Home Manager Profile Dependency Graph](./assets/home_graph.png)

## 🗺️ Network Topology

The network topology visualizations are automatically generated using [nix-topology](https://github.com/oddlama/nix-topology) and provide a comprehensive view of the infrastructure setup across all hosts and networks.

### Main Topology

Complete view of all nodes, networks, and their interconnections:

![Main Network Topology](./assets/topology/main.svg)

### Network View

Focused visualization of network segments and connectivity:

![Network Topology View](./assets/topology/network.svg)

> **Note**: These topology diagrams are automatically built and updated via GitHub Actions whenever topology configurations.

## ❄️Flake Inputs

This flake relies on several external inputs to manage dependencies and configurations:

- **Core & System:**
  - **`nixpkgs`**: The core Nix package set (tracking `nixpkgs-unstable`).
  - **`nixpkgs-master`**: Tracks the master branch of Nixpkgs (used occasionally).
  - **`systems`**: Provides standard system identifiers (e.g., `x86_64-darwin`).
- **Flake Helpers:**
  - **`flake-parts`**: Used for structuring the flake outputs with modularity.
  - **`flake-utils`**: General utilities for flakes.
  - **`devshell`**: Provides convenient development shells.
  - **`pre-commit-hooks`**: Manages Git hooks for code quality and formatting.
  - **`treefmt-nix`**: For code formatting integration.
- **OS Integration:**
  - **`home-manager`**: Manages user-level configurations and dotfiles.
  - **`nix-darwin`**: Enables declarative macOS system configuration.
  - **`nix-homebrew`**: For Homebrew package integration within `nix-darwin`.
  - **`nixos-wsl`**: Provides modules for running NixOS on WSL.
  - **`nix-on-droid`**: Enables declarative Android configuration via Termux fork.
- **Secrets Management:**
  - **`agenix`**: Base library for managing secrets declaratively via age encryption.
  - **`ragenix`**: Rust implementation/wrapper for `agenix`.
  - **`OS-nixCfg-secrets`**: **(Private Repository)** Contains encrypted secrets managed by `ragenix`.
- **Application/Tooling Specific:**
  - **`nix-index-database`**: Provides a database for `nix-index`.
  - **`Vim-Cfg`**: My external Neovim configuration repository (used as a source).
  - **`nvchad4nix`**: Integrates Neovim configurations (like NvChad or custom starters) with Home Manager.
  - **`kanata-tray`**: Provides a system tray application for managing Kanata keyboard remapping presets.
  - **`betterfox`**: Nix integration for Betterfox Firefox hardening.
  - **`brew-nix`**: Alternative Nix integration for Homebrew casks/formulae.
  - **`brew-api`**: Homebrew API data used by `brew-nix`.

_(See `flake.nix` for the complete list and specific sources/versions)_

## 🔒 Secrets Management

Secrets (API keys, passwords, sensitive configurations) are managed via [agenix](https://github.com/ryantm/agenix) or specificaly [ragenix](https://github.com/yaxitech/ragenix).

1.  Secrets are encrypted using `ssh` keys. My public key is explicitly available to `ragenix`.
2.  The encrypted files reside in a **private** GitHub repository: `DivitMittal/OS-nixCfg-secrets`. This repository is referenced as a flake input.
3.  During the Nix build process, `agenix` decrypts these files using my private key.
4.  The decrypted files are placed in the Nix store & symlinked to their target locations.

⚠️ **Building this configuration requires access to the private `DivitMittal/OS-nixCfg-secrets` repo and the corresponding [age](https://github.com/FiloSottile/age) private `ssh` key.**

## 🔗 Related Repositories

- `DivitMittal/OS-nixCfg-secrets`: (Private) Contains encrypted secrets managed by `agenix` & `ragenix`.
- [DivitMittal/Vim-Cfg](https://github.com/DivitMittal/Vim-Cfg): Pure lua standalone Neovim configuration, deployed via `nix4nvchad`.
- [DivitMittal/Emacs-Cfg](https://github.com/DivitMittal/Emacs-Cfg): An elisp doomemacs configuration, used as an input via `nix-doom-emacs-unstraightened`.
- [DivitMittal/TLTR](https://github.com/DivitMittal/TLTR): Cross-platform complex multi-layer keyboard layout tailored for programmers.
- [DivitMittal/hammerspoon-nix](https://github.com/DivitMittal/hammerspoon-nix): A nix home-manager module for hammerspoon & my hammerspoon lua configuration.
- [DivitMittal/firefox-nixCfg](https://github.com/DivitMittal/firefox-nixCfg): A personal nix home-manager module/configurations for firefox.

<div align="right">

[![][back-to-top]](#top)

</div>

[back-to-top]: https://img.shields.io/badge/-BACK_TO_TOP-151515?style=flat-square&color=purple
