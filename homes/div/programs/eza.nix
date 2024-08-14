{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    package = pkgs.eza;

    enableFishIntegration = true; enableZshIntegration = true; enableBashIntegration = false;

    # creates shell aliases for ls & la
    extraOptions = ["--all" "--classify" "--icons=always" "--group-directories-first" "--color=always" "--color-scale" "--color-scale-mode=gradient" "--hyperlink"];
  };

  home.shellAliases = {
    ll = "eza -albhHigUuS -m@ | ov -H1";
    lt = "eza --tree --level=2 | ov -H1";
  };
}