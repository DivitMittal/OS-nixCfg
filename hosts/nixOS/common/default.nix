{ lib, hostname, ... }:

let
  inherit(lib) mkOption;
in
{
  options = let inherit(lib) types; in {
    paths.currentNixOSCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/nixos/${hostname}";
      description = "Path to darwin configs";
    };
  };

  config = {

  };
}