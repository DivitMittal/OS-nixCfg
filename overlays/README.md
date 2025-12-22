# Overlays Directory

Nix package overlays modifying/extending nixpkgs.

## Structure

```
overlays/
├── default.nix       # Main overlay composition (flake-parts module)
└── custom.nix        # Custom package overlays
```

## Exports

The `custom` overlay provides:

- `customDarwin` - macOS-specific packages from `../pkgs/darwin/`
- `customPypi` - Python packages from `../pkgs/pypi/`
- `custom` - General custom packages from `../pkgs/custom/`

All packages are loaded recursively using `packagesFromDirectoryRecursive`.

## Implementation

Custom packages are defined in `custom.nix` using `packagesFromDirectoryRecursive` for automatic discovery.

## Usage

Auto-applied to all systems. Access custom packages via:

```nix
pkgs.customDarwin.myMacPackage
pkgs.customPypi.myPythonPackage
pkgs.custom.myGeneralPackage
```

Use overlays for system-wide changes; use host configs for host-specific packages.
