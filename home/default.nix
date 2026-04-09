{
  mkCfg,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.flakeModules.home-manager];

  flake.homeConfigurations = let
    class = "home";
    fullModules =
      [
        (inputs.import-tree ./tty)
      ]
      ++ [./gui/setup.nix]
      ++ [(inputs.import-tree ./dev)]
      ++ [(inputs.import-tree ./comms)]
      ++ [(inputs.import-tree ./tools)]
      ++ [(inputs.import-tree ./web)]
      ++ [(inputs.import-tree ./media)];
  in {
    L1 = mkCfg {
      hostName = "L1";
      system = "x86_64-darwin";
      inherit class;
      additionalModules = fullModules;
    };

    L2 = mkCfg {
      hostName = "L2";
      system = "x86_64-linux";
      inherit class;
      additionalModules = fullModules;
    };

    WSL = mkCfg {
      hostName = "WSL";
      system = "x86_64-linux";
      inherit class;
      additionalModules = [(inputs.import-tree ./tty)];
    };

    M1 = mkCfg {
      hostName = "M1";
      system = "aarch64-linux";
      inherit class;
      additionalModules = [(inputs.import-tree ./tty)];
    };
  };
}
