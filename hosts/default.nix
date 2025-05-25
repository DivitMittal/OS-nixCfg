{
  inputs,
  mkHost,
  ...
}: {
  flake.darwinConfigurations = let
    class = "darwin";
  in {
    L1 = mkHost {
      inherit class;
      hostName = "L1";
      system = "x86_64-darwin";
    };
  };

  flake.nixosConfigurations = let
    class = "nixos";
  in {
    WSL = mkHost {
      inherit class;
      hostName = "WSL";
      system = "x86_64-linux";
      additionalModules = [
        inputs.nixos-wsl.nixosModules.default
      ];
    };
    # L2 = mkHost {
    #   inherit class;
    #   hostName = "L2";
    #   system = "x86_64-linux";
    #   additionalModules = [
    #     /etc/nixos/hardware-configuration.nix # impure
    #   ];
    # };
  };

  flake.nixOnDroidConfigurations = let
    class = "droid";
  in {
    M1 = mkHost {
      inherit class;
      hostName = "M1";
      system = "aarch64-linux";
    };
  };
}