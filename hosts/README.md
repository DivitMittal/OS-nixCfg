# Hosts Directory

This directory contains platform-specific host configurations for all systems managed by this flake.

## Structure

```
hosts/
├── darwin/        # macOS systems (nix-darwin)
│   ├── L1/       # Primary macOS workstation
│   └── default.nix
├── nixos/         # NixOS systems
│   ├── L2/       # Desktop system
│   ├── WSL/      # WSL2 instance
│   └── default.nix
├── droid/         # Android systems (nix-on-droid)
│   ├── M1/
│   └── default.nix
└── default.nix    # Auto-imports all host configs
```

## Current Hosts

### macOS (darwin)

**L1** - Primary development workstation

- System: x86_64-darwin
- Configuration: nix-darwin
- Features: Full GUI environment, development tools, Hammerspoon automation

### NixOS

**L2** - Desktop system

- System: x86_64-linux
- Hardware: Physical hardware with GRUB bootloader
- Network: Connected to home network via ethernet
- Topology: Defined in `L2/topology.nix`

**WSL** - Windows Subsystem for Linux

- System: x86_64-linux
- Platform: WSL2 on Windows
- Network: Virtual networking through WSL bridge
- Features: Development environment, systemd support
- Topology: Defined in `WSL/topology.nix`

### Android (droid)

**M1** - Mobile device

- Platform: nix-on-droid
- Features: Termux-based Nix environment

## Host Configuration Structure

Each host directory typically contains:

```
hostname/
├── default.nix           # Main system configuration
├── hardware.nix          # Hardware-specific settings (NixOS)
├── topology.nix          # Infrastructure topology (NixOS)
├── home/                 # Host-specific home-manager config
├── programs/             # Host-specific programs
├── services/             # Host-specific services
└── defaults/             # System defaults (macOS)
```

All `.nix` files in a host directory are automatically imported via `lib.custom.scanPaths`.

## Adding a New Host

### For NixOS:

1. Create a new directory under `hosts/nixos/HOSTNAME/`
2. Add `default.nix` with basic configuration:

   ```nix
   {lib, ...}: {
     imports = lib.custom.scanPaths ./.;

     boot.loader.grub = {
       enable = true;
       device = "/dev/sda";
     };

     system.stateVersion = "24.11";
   }
   ```

3. Add hardware configuration in `hardware.nix`
4. Register in `hosts/nixos/default.nix`:

   ```nix
   HOSTNAME = mkHost {
     class = "nixos";
     hostName = "HOSTNAME";
     system = "x86_64-linux";
     additionalModules = commonNixosModules;
   };
   ```

5. (Optional) Add `topology.nix` for visualization

### For macOS (nix-darwin):

1. Create a new directory under `hosts/darwin/HOSTNAME/`
2. Add `default.nix` with basic configuration:

   ```nix
   {lib, ...}: {
     imports = lib.custom.scanPaths ./.;

     system.stateVersion = 4;
   }
   ```

3. Register in `hosts/darwin/default.nix`:
   ```nix
   HOSTNAME = mkHost {
     class = "darwin";
     hostName = "HOSTNAME";
     system = "aarch64-darwin";  # or x86_64-darwin
   };
   ```

### For nix-on-droid:

1. Create a new directory under `hosts/droid/HOSTNAME/`
2. Add `default.nix` with basic configuration
3. Register in `hosts/droid/default.nix`

## Common Patterns

### Host-Specific Overrides

Place host-specific configurations in the host directory:

- GUI applications that only run on certain hosts
- Hardware-specific settings
- Network configurations
- Service configurations unique to the host

### Shared Configurations

Use modules from:

- `../common/` - Configurations shared across all hosts
- `../home/` - Home-manager modules shared across users
- `../modules/` - Custom NixOS/nix-darwin modules

## Building and Deploying

### macOS (L1)

```bash
hts  # Rebuild and switch system configuration
```

### NixOS (L2, WSL)

```bash
# On the target system
hts  # Rebuild and switch system configuration

# Or remotely
nixos-rebuild switch --flake .#L2 --target-host L2
```

### Android (M1)

```bash
nix-on-droid switch --flake .#M1
```

## Related Documentation

- ../flake/README.md - Flake structure and mkHost builder
- ../topology/README.md - Infrastructure visualization
- ../common/README.md - Shared configurations
- CLAUDE.md (root) - Development commands
