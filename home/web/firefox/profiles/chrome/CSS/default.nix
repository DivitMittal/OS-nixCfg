{
  pkgs,
  currentProfileDir,
  ...
}: let
  fx-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "016521f0a21bbb76e8eff4b8410c1e049f081c77";
    hash = "sha256-dUboMxvWSP1PS9NT8PsmfOMF1HKqvH6jUAT1La5k6wM=";
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
