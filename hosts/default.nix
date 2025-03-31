{ inputs, mkHost, ... }:

{
  flake.darwinConfigurations = {
    L1 = mkHost {
      hostName = "L1";
      system = "x86_64-darwin";
      class = "darwin";
    };

    L2 = mkHost {
      hostName = "L2";
      system = "x86_64-linux";
      class = "nixos";
      additionalModules = [
        /etc/nixos/hardware-configuration.nix # impure
      ];
    };

    WSL = mkHost {
      hostName = "WSL";
      system = "x86_64-linux";
      class = "nixos";
      additionalModules = [
        inputs.nixos-wsl.nixosModules.default
      ];
    };
  };
}