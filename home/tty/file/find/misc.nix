{pkgs, ...}: {
  programs.fd = {
    enable = true;
    package = pkgs.fd;

    hidden = true; # creates shell alias
    ignores = [".git/"];
  };

  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;

    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
    enableNushellIntegration = false;
    options = ["--cmd cd"];
  };

  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;

    arguments = ["-i" "--max-columns-preview" "--colors=line:style:bold"];
  };
}