{
  mkHost,
  inputs,
  self,
  ...
}: let
  activateNixOnDroid = configuration:
    inputs.deploy-rs.lib.aarch64-linux.activate.custom
    configuration.activationPackage
    "${configuration.activationPackage}/activate";
in {
  flake.nixOnDroidConfigurations = let
    class = "droid";
  in {
    M1 = mkHost {
      inherit class;
      hostName = "M1";
      system = "aarch64-linux";
    };
  };

  flake.deploy.nodes = {
    M1 = {
      hostname = "M1";
      profiles.system = rec {
        sshUser = "nix-on-droid";
        user = sshUser;
        magicRollback = true;
        sshOpts = ["-p" "8022"];
        path = activateNixOnDroid self.nixOnDroidConfigurations.M1;
      };
    };
  };
}
