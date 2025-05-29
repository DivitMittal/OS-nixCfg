{
  inputs,
  mkHost,
  ...
}: {
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
}
