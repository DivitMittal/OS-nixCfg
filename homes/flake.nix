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
    programs = "${username}/programs";
    configs = "${username}/configs";
  in
  {
    homeConfigurations =  {
      "${username}-L1" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs-darwin;
          inherit username;
        };

        modules = [
          ./${username}

          ./${programs}/communication
          ./${programs}/development
          ./${programs}/media
          ./${programs}/tools
          ./${programs}/tty-env
          ./${programs}/virt
          ./${programs}/web

          ./${configs}/ideavim
          ./${configs}/raycast
        ];
      };

      "${username}-L2" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username;
        };

        modules = [
          ./${username}

          ./${programs}/tty-env
        ];
      };

      "${username}-WSL" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username;
        };

        modules = [
          ./${username}

          ./${programs}/tty-env
        ];
      };
    };
  };
}