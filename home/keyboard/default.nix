{pkgs, ...}: let
  TLTR = pkgs.fetchFromGitHub {
    owner = "DivitMittal";
    repo = "TLTR";
    rev = "master";
    sha256 = "sha256-TIu/E6nWn2Sgdae9x82eUwOEjw675Fk00/Wop3ENoT0=";
  };
in {
  home.packages = [pkgs.kanata-with-cmd];

  imports = [
    (import ./kanata-tray.nix {
      inherit pkgs;
      inherit TLTR;
    })
  ];

  xdg.configFile."karabiner" = {
    enable = false;
    source = "${TLTR}/karabiner";
    recursive = true;
  };
}
