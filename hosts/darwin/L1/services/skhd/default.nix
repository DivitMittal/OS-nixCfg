{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = lib.attrsets.attrVals ["jq"] pkgs;

  services.skhd = {
    enable = true;
    package = pkgs.skhd;

    skhdConfig = lib.strings.readFile ./skhdrc;
  };
}
