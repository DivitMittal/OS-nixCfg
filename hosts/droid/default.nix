{mkHost, ...}: {
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