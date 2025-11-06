# Hosts Directory

Platform-specific host configurations.

## Structure

```
hosts/
├── darwin/        # macOS (nix-darwin)
│   └── L1/       # x86_64-darwin workstation
├── nixos/         # NixOS systems
│   ├── L2/       # x86_64-linux desktop
│   └── WSL/      # x86_64-linux WSL2
└── droid/         # Android (nix-on-droid)
    └── M1/
```

## Host Directory Layout

```
hostname/
├── default.nix
├── hardware.nix      # NixOS only
├── topology.nix      # NixOS only
├── home/             # Host-specific home-manager
├── programs/
└── services/
```

All `.nix` files auto-imported via `lib.custom.scanPaths`.

## Adding Host

1. Create `hosts/{platform}/{hostname}/`
2. Add `default.nix` with config
3. Register in `hosts/{platform}/default.nix` using `mkHost`

## Rebuild

```bash
hts  # System rebuild
```
