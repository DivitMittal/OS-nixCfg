{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = lib.lists.optionals config.services.skhd.enable (lib.attrsets.attrVals ["jq"] pkgs);

  services.skhd = {
    enable = false;
    package = pkgs.skhd;

    skhdConfig = lib.strings.readFile ./skhdrc;
  };
}