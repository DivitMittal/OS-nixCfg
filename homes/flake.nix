{
  description = "home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-stable.url = "github:nixOS/nixpkgs/nixos-24.11";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, ... }@inputs:
  let
    user = {
      fullname = "Divit Mittal";
      username = "div";
      emails = [ "64.69.76.69.74.m@gmail.com" "mittaldivit@gmail.com" ];
    };
    system = builtins.currentSystem; # impure
    pkgs = import inputs.nixpkgs { inherit system; };
    #pkgs-darwin = import inputs.nixpkgs-darwin { inherit system; };
    #pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  in
  {
    homeConfigurations =  {
      "L1" = home-manager.lib.homeManagerConfiguration { # macOS
        inherit pkgs;
        extraSpecialArgs = {
          inherit user;
          #inherit pkgs-stable;
          #inherit pkgs-darwin;
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

      "L2" = home-manager.lib.homeManagerConfiguration { # nixOS
        inherit pkgs;
        extraSpecialArgs = {
          inherit user;
        };

        modules = [
          ./common

          ./programs/tty-env
        ];
      };

      "WSL" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit user;
        };

        modules = [
          ./common

          ./programs/tty-env
        ];
      };

      "Pi" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit user;
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