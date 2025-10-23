# Home Directory

This directory contains home-manager modules organized by category. These modules configure user-level applications, tools, and environments.

## Structure

```
home/
├── ai/           # AI and ML tools
├── comms/        # Communication tools (email, IRC, RSS)
├── dev/          # Development environments (JS, Python, cloud)
├── gui/          # GUI applications and desktop managers
├── keyboard/     # Keyboard configuration (Kanata)
├── media/        # Media players and tools
├── tools/        # Utilities and productivity tools
├── tty/          # Terminal tools (shells, editors, multiplexers, VCS)
├── web/          # Web browsers and related tools
└── default.nix   # Auto-imports all categories
```

## Categories

### ai/

AI and machine learning tools:

- LLM interfaces
- AI-powered development tools
- Model management

### comms/

Communication and information consumption:

- **Email** - Email clients and configuration
- **IRC** - IRC clients (irssi, weechat, etc.)
- **Newsboat** - RSS/Atom feed reader
- Other messaging tools

### dev/

Development environments and tooling:

- **JavaScript/Node.js** - npm, yarn, pnpm, bun
- **Python** - pip, virtualenv, poetry
- **Cloud** - AWS CLI, kubectl, terraform
- Build tools and package managers

### gui/

GUI applications and desktop environments:

- **darwin/** - macOS-specific GUI apps
- **linux/** - Linux-specific GUI apps
- Window managers
- Desktop utilities
- GUI editors

### keyboard/

Keyboard customization and key mapping:

- **Kanata** - Cross-platform keyboard remapper
- Keyboard layouts
- Key binding configurations

### media/

Media consumption and creation:

- Audio players (mpd, ncmpcpp)
- Video players (mpv)
- Image viewers
- Media management tools

### tools/

General utilities and productivity:

- File managers (yazi, ranger)
- System monitors
- Backup tools
- Encryption tools
- Privacy tools

### tty/

Terminal-based tools and environments:

- **Shells** - bash, zsh, fish configuration
- **Editors** - Neovim, Vim, Emacs
- **Multiplexers** - tmux, zellij
- **VCS** - Git, lazygit configuration
- Terminal emulators
- CLI utilities

### web/

Web browsers and extensions:

- **Firefox** - Firefox with custom configuration
- **Chromium** - Chromium-based browsers
- Browser extensions
- Web development tools

## Usage Patterns

### Platform-Specific Modules

Some modules have platform-specific subdirectories:

```
gui/
├── darwin/      # macOS-only GUI apps
├── linux/       # Linux-only GUI apps
└── shared/      # Cross-platform GUI apps
```

### Conditional Loading

Use `lib.mkIf` for conditional configurations:

```nix
programs.firefox.enable = lib.mkIf pkgs.stdenv.isLinux true;
```

### Module Organization

Each category typically contains:

- `default.nix` - Imports all modules in the category
- Individual program configurations (e.g., `git.nix`, `nvim.nix`)
- Subdirectories for complex configurations

## Adding New Modules

1. Choose the appropriate category (or create a new one)
2. Create a `.nix` file for the program/tool
3. The module is automatically imported via `scanPaths`

Example structure:

```nix
# home/dev/rust.nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
  ];

  # Optional: program-specific configuration
  programs.rust = {
    enable = true;
    # ... configuration
  };
}
```

## Home-Manager Configuration

### Global Settings

Set in host configurations:

```nix
home-manager.users.${username} = {
  imports = [
    # Import category modules
    ../home/dev
    ../home/tty
  ];

  # User-specific overrides
  programs.git.userName = "Your Name";
};
```

### Host-Specific Overrides

Place in `hosts/HOSTNAME/home/`:

```nix
# hosts/darwin/L1/home/default.nix
{...}: {
  # macOS-specific home configuration
  programs.foo.darwinSpecific = true;
}
```

## Rebuild Commands

Apply home-manager changes:

```bash
hms   # Rebuild and switch home configuration
hmst  # Rebuild and switch with traces
```

## Configuration Examples

### Minimal Terminal Setup

```nix
imports = [
  ../home/tty/shell
  ../home/tty/git
  ../home/tty/vim
];
```

### Full Development Environment

```nix
imports = [
  ../home/tty        # All terminal tools
  ../home/dev        # All dev environments
  ../home/tools      # Utilities
  ../home/web/firefox
];
```

### GUI Workstation

```nix
imports = [
  ../home/gui       # GUI applications
  ../home/dev       # Development tools
  ../home/media     # Media players
  ../home/comms     # Communication
];
```

## Related Documentation

- ../hosts/README.md - Host configurations
- ../modules/README.md - Custom modules
- ../common/README.md - Shared system configuration
