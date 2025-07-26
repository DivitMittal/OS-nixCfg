# AGENTS.md - OS-nixCfg Development Guide

## Build/Test Commands

- Check flake validity: `nix flake check`
- Build home configuration: `./utils/home_rebuild.sh` or `home-manager switch --flake .#$(hostname)`
- Build system configuration: `./utils/hosts_rebuild.sh`
- Format code: `nix fmt` (uses treefmt-nix)
- Enter dev shell: `nix develop` or `direnv allow` (if using direnv)

## Code Style & Conventions

- **File Structure**: Use `default.nix` as module entry points, import others via `lib.custom.scanPaths`
- **Imports**: Use function parameters `{lib, ...}:` pattern; import external modules via flake inputs
- **Naming**: Use kebab-case for file names, camelCase for Nix attributes
- **Formatting**: Use `alejandra` (applied via `nix fmt`); 2-space indentation
- **Module Pattern**: Modules should return attribute sets with `imports`, `config`, `options` as needed
- **Path Scanning**: Use `lib.custom.scanPaths ./.` to automatically import all .nix files in directory
- **Host-specific**: Platform conditionals via `hostPlatform.isDarwin`, `hostPlatform.isLinux`

## Error Handling

- Use `lib.mkDefault` for default values that can be overridden
- Add descriptive error messages with `builtins.throw` for invalid configurations
- Use `lib.optionals` and `lib.optionalAttrs` for conditional includes

## Testing

- All configurations are tested via GitHub Actions (darwin-build, home-build, nixos-build, flake-check)
- Test locally before committing: run rebuild scripts with `trace` argument for detailed output
