{pkgs, ...}: {
  programs.eza = {
    enable = true;
    package = pkgs.eza;

    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
    enableNushellIntegration = false;
    git = true;

    # creates shell alias for ls
    extraOptions = [
      "--all"
      "--classify"
      "--icons=always"
      "--group-directories-first"
      "--hyperlink"
      "--color=always"
      "--color-scale"
      "--color-scale-mode=gradient"
    ];
  };

  home.shellAliases = {
    ll = "eza -albhHigUuS -m@ | ov -H1";
    lt = "eza --tree --level=2 | ov -H1";
  };
}
