{
  description = "home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-darwin, home-manager, ... }@inputs:
  let
    system = builtins.currentSystem; # impure
    pkgs = import nixpkgs { inherit system; };
    pkgs-darwin = import nixpkgs-darwin { inherit system; };
    username = "div";
  in
  {
    homeConfigurations =  {
      "${username}-L1" = home-manager.lib.homeManagerConfiguration { # macOS
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-darwin;
          inherit username;
        };

        modules = [
          ./common

          ./programs/communication
          ./programs/development
          ./programs/media
          ./programs/tools
          ./programs/tty-env
          ./programs/virt
          ./programs/web

          ./configs/raycast
          ./configs/kanata-tray
        ];
      };

      "${username}-L2" = home-manager.lib.homeManagerConfiguration { # nixOS
        inherit pkgs;
        extraSpecialArgs = {
          inherit username;
        };

        modules = [
          ./common

          ./programs/tty-env
        ];
      };

      "${username}-WSL" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username;
        };

        modules = [
          ./common

          ./programs/tty-env
        ];
      };

      "${username}-Pi" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username;
        };

        modules = [
          ./common

          ./programs/tty-env/editors/vim
          ./programs/tty-env/editors/editorconfig

          ./programs/tty-env/file/find
          ./programs/tty-env/file/yazi

          ./programs/tty-env/multiplexers/zellij.nix

          ./programs/tty-env/pagers

          ./programs/tty-env/shells/common.nix
          ./programs/tty-env/shells/bash

          ./programs/tty-env/vcs

          ./programs/tty-env/atuin.nix
          ./programs/tty-env/btop.nix
          ./programs/tty-env/eza.nix
          ./programs/tty-env/fastfetch.nix
          ./programs/tty-env/starship.nix

          ./programs/web/tui.nix
        ];
      };
    };
  };
}