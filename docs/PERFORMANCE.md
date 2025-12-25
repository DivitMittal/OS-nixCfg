# Performance Considerations

This document outlines performance considerations and optimizations used in this Nix configuration.

## Evaluation Performance

### 1. Package Set (pkgs) Configuration

**Trade-off: Memoization vs. Customization**

This flake uses non-memoized `pkgs` to enable custom configuration and overlays:

```nix
_module.args.pkgs = builtins.import nixpkgs {
  inherit system;
  config = { /* custom config */ };
  overlays = [ /* custom overlays */ ];
};
```

**Why not memoized?**
- The memoized version `inputs.nixpkgs.legacyPackages.${system}` would not include our custom overlays and configuration
- We need `allowUnfree`, custom overlays, and other config options
- The evaluation time trade-off is acceptable for the flexibility gained

**Impact:** Slight increase in evaluation time per system, but necessary for customization.

### 2. Directory Scanning with `scanPaths`

**Function:** `lib.custom.scanPaths`

The `scanPaths` function is used extensively (~50 times) to automatically discover and import Nix modules.

**Optimization:**
- Nix's evaluation cache ensures `builtins.readDir` results are memoized per unique path
- Multiple calls to `scanPaths` with the same path don't re-read the directory
- The function filters out `default.nix` from the current directory to prevent infinite recursion

**Usage pattern:**
```nix
imports = lib.custom.scanPaths ./.;
```

**Performance characteristics:**
- Directory reads happen at evaluation time (not build time)
- Results are cached within a single Nix evaluation
- Adds negligible overhead compared to manual imports
- Provides better maintainability by auto-discovering modules

### 3. Module Imports

**Pattern:** Centralized module definitions in `modules/default.nix`

All module imports are centralized and exposed as flake outputs. This:
- Provides clear entry points for modules
- Allows selective importing of individual modules
- Maintains consistency across different configurations

**Best practice:**
```nix
# Instead of scattering imports
imports = [ ./module1.nix ./module2.nix ];

# Use the centralized pattern
imports = [ inputs.self.homeManagerModules.all ];
```

### 4. Overlay Structure

**Organization:** Platform-specific overlays

Custom packages are organized by platform:
- `customDarwin`: macOS-specific packages
- `customPypi`: Python packages
- `custom`: Cross-platform packages

**Optimization:**
- Uses `lib.packagesFromDirectoryRecursive` for lazy evaluation
- Packages are only evaluated when actually used
- Directory structure is scanned once and cached
- Platform-specific packages are isolated to avoid unnecessary evaluation

## Build Performance

### 1. Lazy Evaluation

Nix's lazy evaluation means that:
- Packages are only built when needed
- Configuration options are only evaluated when referenced
- Unused modules don't impact build time

### 2. Binary Caches

The flake configures trusted binary caches to speed up builds:
- `cache.nixos.org` (default)
- `yazi.cachix.org`
- `wezterm.cachix.org`
- `cache.lix.systems`
- `cache.numtide.com`

These caches provide pre-built binaries for most packages, dramatically reducing build times.

### 3. Parallel Builds

Nix automatically parallelizes builds when possible. Ensure your system configuration allows this:
- `nix.settings.max-jobs` - number of parallel builds
- `nix.settings.cores` - CPU cores per build

## Best Practices

### DO ✅

1. **Use `lib.custom.scanPaths` for auto-discovery**
   - Maintains consistency
   - Reduces manual maintenance
   - Leverages evaluation caching

2. **Keep modules modular and focused**
   - Smaller modules evaluate faster
   - Easier to maintain and debug
   - Better for selective imports

3. **Leverage binary caches**
   - Configure trusted caches in `nixConfig`
   - Use cachix for custom packages
   - Enable parallel downloads

4. **Use `lib` functions over builtins where possible**
   - Better optimized
   - More consistent behavior
   - Clearer code

### DON'T ❌

1. **Don't use `builtins.readDir` in tight loops**
   - Can cause excessive filesystem operations
   - Use scanPaths or similar helper functions

2. **Don't import the same module multiple times**
   - Leverage flake outputs
   - Use module system's `imports` properly

3. **Don't use `builtins.getEnv` unless necessary**
   - Makes evaluation impure
   - Can cause cache invalidation
   - Use proper configuration options instead

4. **Don't create deep recursion in imports**
   - Can cause stack overflow
   - Harder to debug
   - Use explicit imports when needed

## Profiling and Debugging

### Evaluation Time

To see evaluation time and statistics:

```bash
# Show evaluation stats
nix flake show --show-trace --verbose

# Time a specific build
time nix build .#homeConfigurations.L1.activationPackage

# Use trace for debugging
nix build --show-trace
```

### Build Time

To optimize build times:

```bash
# Enable verbose output
nix build --verbose

# Show why packages are being built
nix build --show-trace

# Check what's being fetched
nix build --print-build-logs
```

## Monitoring Performance

Key metrics to watch:
1. **Evaluation time**: Time to parse and evaluate Nix expressions
2. **Download time**: Time to fetch from binary caches
3. **Build time**: Time to build packages from source
4. **Store size**: Disk space used by Nix store

Regular maintenance:
```bash
# Clean old generations
nix-collect-garbage -d

# Optimize store
nix-store --optimize

# Check store size
du -sh /nix/store
```

## Future Optimizations

Potential areas for future improvement:

1. **Flake-parts modularization**: Further split into focused modules
2. **Conditional imports**: Only import platform-specific modules when needed
3. **Build caching**: Set up custom binary cache for frequently built packages
4. **Profile-based optimization**: Create minimal profiles for faster evaluation

## References

- [Nix Manual - Evaluation](https://nixos.org/manual/nix/stable/)
- [Nixpkgs Manual - Best Practices](https://nixos.org/manual/nixpkgs/stable/)
- [Flake-parts Documentation](https://flake.parts/)
