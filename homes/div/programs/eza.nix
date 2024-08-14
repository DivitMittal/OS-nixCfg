{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    package = pkgs.eza;

    enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false;
    git = true;

    # creates shell aliases for ls & la
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