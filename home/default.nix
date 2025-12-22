{
  mkCfg,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.home-manager.flakeModules.home-manager];

  flake.homeConfigurations = let
    class = "home";
  in {
    L1 = mkCfg {
      hostName = "L1";
      system = "x86_64-darwin";
      inherit class;
      additionalModules = lib.custom.scanPaths ./.;
    };

    L2 = mkCfg {
      hostName = "L2";
      system = "x86_64-linux";
      inherit class;
      additionalModules = lib.custom.scanPaths ./.;
    };

    WSL = mkCfg {
      hostName = "WSL";
      system = "x86_64-linux";
      inherit class;
      additionalModules = [./tty];
    };

    M1 = mkCfg {
      hostName = "M1";
      system = "aarch64-linux";
      inherit class;
      additionalModules = [./tty];
    };
  };
}
