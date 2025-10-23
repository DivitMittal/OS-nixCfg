# Common Directory

This directory contains configurations shared across all hosts and users in the flake.

## Structure

```
common/
├── all/          # Configurations for all systems (all platforms)
├── home/         # Common home-manager configurations
├── hosts/        # Common host/system configurations
└── default.nix   # Auto-imports all common configs
```

## Purpose

The `common/` directory provides:

- **Baseline configurations** applied to every system
- **Shared settings** that shouldn't be duplicated
- **Default behaviors** that can be overridden per-host

## Subdirectories

### all/

Universal configurations applied to every system regardless of platform:

- Core utilities available everywhere
- Basic environment variables
- Universal aliases and functions
- Shared Nix settings

### home/

Common home-manager configurations shared across all users:

- Default user settings
- Common program configurations
- Shared dotfiles and scripts
- Universal home packages

Example content:

- Basic shell configuration
- Common editor settings
- Shared Git configuration
- Universal CLI tools

### hosts/

Common system-level configurations shared across all hosts:

- System-wide packages
- Network configuration defaults
- Security settings
- Locale and timezone defaults
- Nix daemon settings

Platform-specific subdirectories may include:

- `darwin/` - macOS-specific system settings
- `nixos/` - NixOS-specific system settings
- `droid/` - nix-on-droid specific settings

## Usage Pattern

### Automatic Import

Common configurations are automatically imported by the `mkHost` builder for all systems.

### Override Hierarchy

Configuration priority (lowest to highest):

1. `common/` - Base defaults
2. `hosts/PLATFORM/` - Platform-specific defaults
3. `hosts/PLATFORM/HOSTNAME/` - Host-specific overrides
4. `hosts/PLATFORM/HOSTNAME/home/` - Host+user specific overrides

### Example Override

```nix
# common/all/timezone.nix
time.timeZone = "UTC";  # Default for all

# hosts/darwin/L1/default.nix
time.timeZone = "America/Los_Angeles";  # Override for L1
```

## Adding Common Configurations

### For All Systems

Place in `common/all/`:

```nix
# common/all/nix-settings.nix
{...}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
}
```

### For All Users

Place in `common/home/`:

```nix
# common/home/git.nix
{...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
```

### For All Hosts (System-Level)

Place in `common/hosts/`:

```nix
# common/hosts/networking.nix
{...}: {
  networking = {
    firewall.enable = true;
    useDHCP = false;
  };
}
```

## Best Practices

### When to Use Common

Use `common/` for:

- ✅ Settings that apply to 90%+ of systems
- ✅ Baseline configurations that others build upon
- ✅ Organization-wide standards
- ✅ Default behaviors that can be overridden

### When NOT to Use Common

Avoid `common/` for:

- ❌ Host-specific configurations
- ❌ User-specific preferences
- ❌ Experimental or temporary settings
- ❌ Platform-specific configurations (use platform subdirs instead)

### Keep It Minimal

The common directory should contain only:

- Essential shared configurations
- Widely applicable defaults
- Base system requirements

Specific configurations belong in:

- `home/` for user applications
- `hosts/` for host-specific settings
- `modules/` for reusable components

## Examples

### Minimal Common Setup

```nix
common/
├── all/
│   └── nix.nix          # Nix daemon settings
├── home/
│   ├── shell.nix        # Basic shell config
│   └── git.nix          # Git basics
└── hosts/
    └── locale.nix       # System locale
```

### Complete Common Setup

```nix
common/
├── all/
│   ├── nix.nix
│   ├── environment.nix
│   └── aliases.nix
├── home/
│   ├── shell/
│   ├── editor/
│   ├── git.nix
│   └── ssh.nix
└── hosts/
    ├── darwin/
    ├── nixos/
    └── shared/
```

## Related Documentation

- ../hosts/README.md - Host-specific configurations
- ../home/README.md - User-level configurations
- ../modules/README.md - Custom reusable modules
