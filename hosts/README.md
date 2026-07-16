# Hosts Directory

Platform-specific host configurations. Each platform directory contains an
`enum.nix` that enumerates the platform's hosts via `mkCfg`, plus one
subdirectory per host.

## Structure

```
hosts/
├── darwin/                     # macOS (nix-darwin)
│   ├── enum.nix
│   ├── L1/                     # x86_64-darwin workstation
│   └── ASL1/                   # aarch64-darwin workstation
├── nixos/                      # NixOS systems
│   ├── enum.nix
│   ├── L2/                     # x86_64-linux desktop
│   ├── T2/                     # x86_64-linux T2 MacBook
│   ├── ASL1N/                  # aarch64-linux on ASL1
│   ├── colima/                 # x86_64-linux VM
│   ├── VPS1/                   # x86_64-linux VPS (Mumbai)
│   ├── VPS2/                   # x86_64-linux VPS (Germany)
│   └── WSL/                    # x86_64-linux WSL2
├── droid/                      # Android (nix-on-droid)
│   ├── enum.nix
│   └── M1/                     # aarch64-linux Android
└── iso/                        # ISO builds (NixOS install media)
    ├── enum.nix
    ├── iso/                    # x86_64-linux vanilla
    ├── t2-iso/                 # x86_64-linux T2
    └── as-iso/                 # aarch64-linux Apple Silicon
```

## Host Directory Layout

Files are auto-imported via `lib.custom.scanPaths`. The host's primary
module is `<hostName>.nix`; supplementary files vary by platform.

Typical NixOS host:

```
hostname/
├── hostname.nix                # primary config
├── hardware.nix                # nixos-generate-config output
├── topology.nix                # network topology position
├── disko.nix                   # disk layout
├── home/                       # host-specific home-manager
├── programs/
└── services/
```

Darwin host:

```
hostname/
├── hostname.nix                # primary config
├── fstab.nix                   # mountpoints
├── defaults/                   # macOS `defaults` overrides
├── programs/
└── services/
```

## Adding Host

1. Create `hosts/{platform}/{hostname}/`
2. Add `<hostName>.nix` (and any platform-specific files)
3. Register in `hosts/{platform}/enum.nix` using `mkCfg`

## Rebuild

```bash
hts  # System rebuild
```

## Remote NixOS Bootstrap

Use `nixos-anywhere` for first install/reinstall of any NixOS host declared in
`.#nixosConfigurations`. The devshell provides a thin safety wrapper named
`bootstrap-nixos` that keeps host details explicit instead of baking provider
endpoints into the script.

Enter the devshell first:

```bash
nix develop
```

Run non-destructive checks against a rescue/current Linux SSH target:

```bash
bootstrap-nixos <host> --target root@203.0.113.10 --check
```

Then run the destructive install only after confirming the SSH target and checked
disk are correct:

```bash
bootstrap-nixos <host> --target root@203.0.113.10 --yes-destroy-disk
```

By default the wrapper checks `/dev/sda` before install. Override that when a
host's disko layout targets a different device:

```bash
bootstrap-nixos <host> --target root@203.0.113.10 --disk /dev/vda --check
```

The wrapper evaluates `.#nixosConfigurations.<host>` locally, checks SSH access,
checks the target disk, then calls `nixos-anywhere --flake .#<host> --build-on
remote`. Remote building is the default because this workstation may be macOS
while the target is Linux.

If an agenix identity is needed on the installed system, the wrapper copies a
local private key into the new root as `/var/lib/agenix/id_ed25519` via
`nixos-anywhere --extra-files`. By default it uses
`${HOME}/.ssh/agenix/id_ed25519` or `AGENIX_IDENTITY_PATH`; pass
`--agenix-identity <path>` to be explicit, or `--no-agenix` for hosts that do not
need system-level agenix at bootstrap. Never commit this private key.

Useful options:

```bash
bootstrap-nixos <host> --target root@203.0.113.10 --port 2222 --check
bootstrap-nixos <host> --target root@203.0.113.10 --ssh-identity ~/.ssh/rescue --check
bootstrap-nixos <host> --target root@203.0.113.10 --build-on auto --check
```

### VPS Examples

`VPS1` and `VPS2` are already first-class NixOS hosts in this flake:

- `VPS1` is the Mumbai KVM VPS. It uses static private IPv4
  `10.10.10.51/24` and is reached for deploys through public NAT at
  `148.113.8.216:20041`.
- `VPS2` is the Germany KVM VPS. It is IPv6-only at
  `2a0e:97c0:3e3:34d::1/64` with gateway `fe80::1` on `eth0`.

Both current VPS disko layouts target `/dev/sda`.

```bash
bootstrap-nixos VPS1 --target root@148.113.8.216 --port 20041 --check
bootstrap-nixos VPS1 --target root@148.113.8.216 --port 20041 --yes-destroy-disk

bootstrap-nixos VPS2 --target root@2a0e:97c0:3e3:34d::1 --check
bootstrap-nixos VPS2 --target root@2a0e:97c0:3e3:34d::1 --yes-destroy-disk
```

### Steady-state deploys

After bootstrap, use deploy-rs rather than `nixos-anywhere`:

```bash
nix eval --raw .#nixosConfigurations.VPS1.config.system.build.toplevel.drvPath
nix eval --raw .#nixosConfigurations.VPS2.config.system.build.toplevel.drvPath
deploy .#VPS1 --dry-activate
deploy .#VPS2 --dry-activate
deploy .#VPS1
deploy .#VPS2
```

The VPS deploy nodes intentionally use `magicRollback = false`, so the recovery
plan for broken network/SSH changes is provider console or rescue mode. They
also use `remoteBuild = true` so Linux closures build on the VPSes instead of
the macOS workstation. Prefer local evaluation, dry activation, SSH smoke tests,
and one host at a time for risky VPS changes.

### Home Manager on VPSes

`VPS1` and `VPS2` embed Home Manager as part of the NixOS system activation via
`hosts/nixos/profiles/headless-home.nix`. This keeps the terminal/dev user
profile deployed atomically with the host and avoids separate standalone
`homeConfigurations.VPS1` / `homeConfigurations.VPS2` deploy profiles.
