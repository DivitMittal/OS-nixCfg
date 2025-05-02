{
  pkgs,
  currentProfileDir,
  ...
}: let
  fx-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "7f4f4511badf6fc8b66c77ddda3244bf4363147b";
    hash = "sha256-VFzix2atMyPX4HPNKDa9FaF1k1/1a2PqOJVeXRVRBxo=";
  };
in {
  home.file."${currentProfileDir}/chrome/CSS/fx-csshacks" = {
    source = fx-csshacks;
    recursive = true;
  };

  home.file."${currentProfileDir}/chrome/CSS/custom" = {
    source = ./custom;
    recursive = true;
  };
}