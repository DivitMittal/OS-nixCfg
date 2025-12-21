{mkHost, ...}: let
  class = "iso";
in {
  flake.nixosConfigurations = {
    iso = mkHost {
      inherit class;
      hostName = "iso";
      system = "x86_64-linux";
    };
    t2-iso = mkHost {
      inherit class;
      hostName = "t2-iso";
      system = "x86_64-linux";
    };
  };
}
