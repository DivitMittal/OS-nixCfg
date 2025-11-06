# Lib Directory

Custom library functions extending nixpkgs `lib`.

## Structure

```
lib/
├── custom.nix      # Custom utilities
└── default.nix     # Exports
```

## Key Function: scanPaths

Auto-imports all `.nix` files in a directory (except `default.nix`):

```nix
{lib, ...}: {
  imports = lib.custom.scanPaths ./.;
}
```

Prevents recursion, automatically picks up new files, used throughout flake.

## Adding Functions

```nix
# lib/custom.nix
{lib}: {
  myFunction = arg: {
    # Implementation
  };
}
```

Access via `lib.custom.myFunction`.
