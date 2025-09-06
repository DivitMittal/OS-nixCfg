{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.jujutsu = {
    enable = true;
    package = pkgs.jujutsu;

    settings = {
      user = {
        name = config.hostSpec.userFullName;
        email = config.hostSpec.email.dev;
      };
    };
  };

  home.packages = lib.attrsets.attrValues {
    inherit (pkgs) lazyjj;
  };
}
