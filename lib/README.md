# Lib Directory

This directory contains custom library functions that extend nixpkgs `lib` with project-specific utilities.

## Structure

```
lib/
├── custom.nix      # Custom utility functions
└── default.nix     # Exports lib extensions
```

## Purpose

Custom library functions provide:

- **Reusable utilities** used across the flake
- **Helper functions** for common operations
- **Code organization** through DRY principles
- **Type-safe abstractions** for complex operations

## Current Functions

### scanPaths

The primary utility function in this flake:

```nix
scanPaths = path:
  builtins.map
    (f: (path + "/${f}"))
    (builtins.filter
      (f: f != "default.nix")
      (builtins.attrNames (builtins.readDir path)));
```

**Purpose**: Automatically import all `.nix` files in a directory (except `default.nix`)

**Usage**:

```nix
# In any default.nix
{lib, ...}: {
  imports = lib.custom.scanPaths ./.;
}
```

**Benefits**:

- No need to manually list imports
- Automatically picks up new files
- Excludes `default.nix` to prevent recursion
- Consistent import pattern across the flake

## Adding Custom Functions

### Basic Function

```nix
# lib/custom.nix
{lib}: {
  # Existing functions...

  myFunction = arg: {
    # Your implementation
  };
}
```

### Function with Dependencies

```nix
# lib/custom.nix
{lib}: {
  # Use nixpkgs lib functions
  filterEnabled = configs:
    lib.filterAttrs (name: cfg: cfg.enable) configs;

  mapToList = attrs: f:
    lib.mapAttrsToList (name: value: f name value) attrs;
}
```

## Usage in Flake

Library extensions are made available via the flake:

```nix
# flake.nix
specialArgs.lib = nixpkgs.lib.extend (_: super: {
  custom = builtins.import ./lib/custom.nix {lib = super;};
});
```

Access anywhere in the configuration:

```nix
{lib, ...}: {
  # Use custom functions
  imports = lib.custom.scanPaths ./.;

  # Use standard lib functions
  options.myOption = lib.mkOption { ... };
}
```

## Common Patterns

### Directory Scanning

```nix
{lib, ...}: {
  # Import all modules in a directory
  imports = lib.custom.scanPaths ./modules;

  # Import all host configurations
  imports = lib.custom.scanPaths ../hosts;
}
```

### Combining with Standard lib

```nix
{lib, ...}: let
  # Custom function
  configs = lib.custom.scanPaths ./config;

  # Standard lib function
  enabled = lib.filter (c: c.enable) configs;
in {
  imports = enabled;
}
```

## Best Practices

### When to Add Custom Functions

Add to `lib/custom.nix` when:

- ✅ Function is used in 3+ places
- ✅ Logic is complex and benefits from extraction
- ✅ Operation is project-specific
- ✅ Function improves code readability

### When NOT to Add Custom Functions

Don't add custom functions if:

- ❌ Nixpkgs lib already provides it
- ❌ Function is used in only one place
- ❌ Logic is trivial (one-liner)
- ❌ Function is host/user-specific

### Function Guidelines

1. **Name Clearly**: Use descriptive, self-documenting names
2. **Document**: Add comments explaining purpose and usage
3. **Type Safety**: Use lib.types for validation where applicable
4. **Test Mentally**: Consider edge cases
5. **Keep Pure**: Functions should be pure (no side effects)

## Example Custom Functions

### Path Utilities

```nix
{lib}: {
  # Get all subdirectories
  getSubdirs = path:
    lib.filterAttrs
      (name: type: type == "directory")
      (builtins.readDir path);

  # Check if path exists
  pathExists = path:
    builtins.pathExists path;
}
```

### Configuration Helpers

```nix
{lib}: {
  # Merge multiple configs with priority
  mergeConfigs = configs:
    lib.foldl' lib.recursiveUpdate {} configs;

  # Enable multiple programs
  enablePrograms = programs:
    lib.genAttrs programs (name: { enable = true; });
}
```

### String Utilities

```nix
{lib}: {
  # Convert camelCase to snake_case
  toSnakeCase = str:
    lib.toLower (builtins.replaceStrings
      (lib.stringToCharacters "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
      (map (c: "_" + c) (lib.stringToCharacters "abcdefghijklmnopqrstuvwxyz"))
      str);
}
```

## Related Documentation

- ../flake/README.md - Flake structure
- [Nixpkgs Manual - Lib Functions](https://nixos.org/manual/nixpkgs/stable/#chap-functions)
- [Nix Manual - Built-in Functions](https://nixos.org/manual/nix/stable/language/builtins.html)
