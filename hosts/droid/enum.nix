{mkCfg, ...}: {
  flake.nixOnDroidConfigurations = let
    class = "droid";
  in {
    M1 = mkCfg {
      inherit class;
      hostName = "M1";
      system = "aarch64-linux";
    };
  };
}
