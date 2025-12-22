# Common Directory

Shared configurations applied to all hosts and users.

## Structure

```
common/
├── all/          # Universal configs for all platforms
├── home/         # Common home-manager configs
└── hosts/        # Common host/system configs
    ├── all/      # Universal host configs
    ├── darwin/   # macOS-specific
    ├── nixos/    # NixOS-specific
    ├── droid/    # nix-on-droid-specific
    └── iso/      # ISO build-specific
```

## Override Hierarchy

1. `common/` - Base defaults
2. `hosts/PLATFORM/` - Platform defaults
3. `hosts/PLATFORM/HOSTNAME/` - Host overrides
4. `hosts/PLATFORM/HOSTNAME/home/` - Host+user overrides

## Usage

Common configs are automatically imported by `mkCfg` builder. Place widely applicable settings here; host-specific configs belong in `hosts/`.
