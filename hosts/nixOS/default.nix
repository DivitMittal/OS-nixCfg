{ self, inputs, ... }:

{
  flake.nixosConfigurations = {
    L2 = let
      hostname = "L2";
      system = "x86_64-linux";
    in inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = import inputs.nixpkgs { inherit system; };
        specialArgs = {
          user = self.user;
          inherit hostname;
          # pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
        };

        modules = [
          ./../common
          ./common
          ./${hostname}
          inputs.nix-index-database.darwinModules.nix-index { programs.nix-index.enable = false; programs.nix-index-database.comma.enable = true; }
        ];
    };

    WSL = let
      hostname = "WSL";
      system = "x86_64-linux";
    in inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = import inputs.nixpkgs { inherit system; };
        specialArgs = {
          user = self.user;
          inherit hostname;
          # pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
        };

        modules = [
          ./../common
          ./common
          inputs.nix-index-database.darwinModules.nix-index { programs.nix-index.enable = false; programs.nix-index-database.comma.enable = true; }
          inputs.nixos-wsl.nixosModules.default
        ];
    };
  };
}