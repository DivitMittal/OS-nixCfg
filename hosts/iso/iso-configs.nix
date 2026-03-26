{mkCfg, ...}: let
  class = "iso";
in {
  flake.nixosConfigurations = {
    iso = mkCfg {
      inherit class;
      hostName = "iso";
      system = "x86_64-linux";
    };
    t2-iso = mkCfg {
      inherit class;
      hostName = "t2-iso";
      system = "x86_64-linux";
    };
  };
}
