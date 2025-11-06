# Overlays Directory

Nix package overlays modifying/extending nixpkgs.

## Structure

```
overlays/
├── default.nix       # Main overlay composition
└── nixpkgs.nix       # Package modifications
```

## Exports

- `default` - Combined overlays
- `pkgs-master` - nixpkgs master branch
- `pkgs-nixos` - NixOS stable
- `pkgs-darwin` - macOS stable
- `custom` - Custom packages from `../pkgs/`

## Basic Overlay

```nix
final: prev: {
  # Modify existing
  myPackage = prev.myPackage.overrideAttrs (old: {
    version = "2.0.0";
  });

  # Add new
  myNewPackage = final.callPackage ../pkgs/my-new-package {};
}
```

## Usage

Auto-applied to all systems. Access via:

```nix
pkgs.myPackage
pkgs.pkgs-master.neovim
```

Use overlays for system-wide changes; use host configs for host-specific packages.
