{
  inputs,
  mkCfg,
  ...
}: {
  flake.nixosConfigurations = let
    class = "nixos";
  in {
    WSL = mkCfg {
      inherit class;
      hostName = "WSL";
      system = "x86_64-linux";
      additionalModules = [inputs.nixos-wsl.nixosModules.default];
    };
    L2 = mkCfg {
      inherit class;
      hostName = "L2";
      system = "x86_64-linux";
    };
  };
}
