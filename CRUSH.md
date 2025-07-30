# OS-nixCfg Development Guide for AI Agents

This guide provides commands and conventions for working in the OS-nixCfg repository.

## Build/Test Commands

- **Check flake validity**: `nix flake check`
- **Format code**: `nix fmt`
- **Enter dev shell**: `nix develop` or `direnv allow`
- **Build home configuration**: `./utils/home_rebuild.sh`
- **Build system configuration**: `./utils/hosts_rebuild.sh`
- **Detailed build output**: Pass `trace` as the first argument to the rebuild scripts (e.g., `./utils/home_rebuild.sh trace`).

## Code Style & Conventions

- **File Structure**: Use `default.nix` as module entry points.
- **Imports**: Use the `{lib, ...}:` function parameter pattern. Import external modules via flake inputs.
- **Naming**: Use kebab-case for file names and camelCase for Nix attributes.
- **Formatting**: Use `alejandra` (applied via `nix fmt`) with 2-space indentation.
- **Module Pattern**: Modules should return attribute sets with `imports`, `config`, `options` as needed.
- **Error Handling**: Use `lib.mkDefault` for overridable default values and `builtins.throw` for error messages.
- **Conditionals**: Use `lib.optionals` and `lib.optionalAttrs` for conditional includes.
- **Host-specific Logic**: Use `hostPlatform.isDarwin` and `hostPlatform.isLinux` for platform-specific configurations.
