{pkgs, ...}: let
  glamourStyles = pkgs.fetchFromGitHub {
    owner = "charmbracelet";
    repo = "glamour";
    rev = "0af1a2d9bc9e9d52422b26440fe218c69f9afbdd";
    hash = "sha256-ZnkYUVtpGGfZHOKx3I4mnMYaXGiMoSNuviz+ooENmbc=";
  };
in {
  programs.glow = {
    enable = true;
    package = pkgs.glow;
    settings = {
      style = "${glamourStyles}/styles/pink.json";
      mouse = true;
      pager = true;
      width = 80;
      all = true;
    };
  };
}
