{mkCfg, ...}: {
  flake.darwinConfigurations = let
    class = "darwin";
  in {
    L1 = mkCfg {
      inherit class;
      hostName = "L1";
      system = "x86_64-darwin";
    };
  };
}
