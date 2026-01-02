_: {
  programs.claude-code.skills = {
    nix-flakes = ''
      ---
      name: nix-flakes
      description: Deep knowledge of Nix flakes. Use when working with flake.nix, inputs, or outputs.
      ---

      # Nix Flakes Expertise

      ## Flake Structure
      ```nix
      {
        inputs = {
          nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
          home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
          };
        };

        outputs = { self, nixpkgs, ... }@inputs: {
          nixosConfigurations.hostname = nixpkgs.lib.nixosSystem { ... };
          darwinConfigurations.hostname = darwin.lib.darwinSystem { ... };
          homeConfigurations.user = home-manager.lib.homeManagerConfiguration { ... };
          packages.x86_64-linux.default = ...;
          devShells.x86_64-linux.default = ...;
        };
      }
      ```

      ## Common Commands
      - `nix flake check` - Validate flake
      - `nix flake update` - Update all inputs
      - `nix flake lock --update-input nixpkgs` - Update single input
      - `nix build .#package` - Build specific output
      - `nix develop` - Enter dev shell

      ## Best Practices
      - Use `follows` to deduplicate nixpkgs instances
      - Pin inputs with `flake.lock`
      - Use `flake-parts` for large flakes
      - Keep outputs organized with let bindings
    '';

    home-manager-modules = ''
      ---
      name: home-manager-modules
      description: Home Manager module patterns. Use when creating or modifying home-manager configs.
      ---

      # Home Manager Module Patterns

      ## Module Structure
      ```nix
      { config, lib, pkgs, ... }:
      let
        cfg = config.programs.myProgram;
      in {
        options.programs.myProgram = {
          enable = lib.mkEnableOption "myProgram";
          package = lib.mkPackageOption pkgs "myProgram" {};
          settings = lib.mkOption {
            type = lib.types.attrsOf lib.types.anything;
            default = {};
            description = "Configuration options";
          };
        };

        config = lib.mkIf cfg.enable {
          home.packages = [ cfg.package ];
          xdg.configFile."myProgram/config.json".source =
            pkgs.formats.json {}.generate "config.json" cfg.settings;
        };
      }
      ```

      ## Common Patterns
      - Use `xdg.configFile` for dotfiles
      - Use `home.file` for non-XDG locations
      - Use `pkgs.formats.*` for config generation
      - Prefer `lib.mkPackageOption` over manual package options
      - Use `lib.mkMerge` for conditional config sections
    '';

    conventional-commits = ''
      ---
      name: conventional-commits
      description: Conventional Commits format. Use when creating commit messages.
      ---

      # Conventional Commits

      ## Format
      ```
      <type>(<scope>): <description>

      [optional body]

      [optional footer(s)]
      ```

      ## Types
      - `feat`: New feature
      - `fix`: Bug fix
      - `docs`: Documentation only
      - `style`: Formatting, no code change
      - `refactor`: Code change, no feature/fix
      - `perf`: Performance improvement
      - `test`: Adding/fixing tests
      - `chore`: Build, tools, deps
      - `ci`: CI configuration

      ## Scope Examples (for this repo)
      - `home`: Home manager configs
      - `darwin`: macOS-specific
      - `nixos`: NixOS-specific
      - `flake`: Flake inputs/outputs
      - `module`: Custom modules
      - `pkg`: Custom packages

      ## Examples
      - `feat(home): add starship prompt configuration`
      - `fix(darwin): resolve homebrew cask conflicts`
    '';
  };
}
