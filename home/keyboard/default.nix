{pkgs, ...}: let
  TLTR = pkgs.fetchFromGitHub {
    owner = "DivitMittal";
    repo = "TLTR";
    rev = "master";
    sha256 = "sha256-ocTMSUUZ26oLsQ0skAc586dqTBPHy+CCWEUN2mQoZiA=";
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