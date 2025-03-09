{ pkgs, ... }:

let
  TLTR = pkgs.fetchFromGitHub {
    owner = "DivitMittal";
    repo = "TLTR";
    rev = "5a69053e2044dc0f88fe50605f0752f6389a8681";
    sha256 = "sha256-TIu/E6nWn2Sgdae9x82eUwOEjw675Fk00/Wop3ENoT0=";
  };
in
{
  imports = [
    (import ./kanata-tray { inherit pkgs; inherit TLTR; })
  ];

  xdg.configFile."karabiner" = {
    enable = false;
    source = "${TLTR}/karabiner";
    recursive = true;
  };
}