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
    colima = mkCfg {
      inherit class;
      hostName = "colima";
      system = "x86_64-linux";
    };
    colima-arm = mkCfg {
      inherit class;
      hostName = "colima";
      system = "aarch64-linux";
    };
    L2 = mkCfg {
      inherit class;
      hostName = "L2";
      system = "x86_64-linux";
    };
    T2 = mkCfg {
      inherit class;
      hostName = "T2";
      system = "x86_64-linux";
    };
    AS = mkCfg {
      inherit class;
      hostName = "AS";
      system = "aarch64-linux";
    };
  };
}
