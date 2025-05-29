{mkHost, ...}: {
  flake.darwinConfigurations = let
    class = "darwin";
  in {
    L1 = mkHost {
      inherit class;
      hostName = "L1";
      system = "x86_64-darwin";
    };
  };
}
