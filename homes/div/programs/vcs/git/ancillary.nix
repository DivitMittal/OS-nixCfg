{ pkgs, ... }:

{
  programs.gh = {
    enable = true;
    package = pkgs.gh;
    extensions = with pkgs; [ gh-eco gh-dash ];

    gitCredentialHelper = {
      enable = true;
      hosts = [ "https://github.com" "https://gist.github.com" ];
    };
    settings = {
      git_protocol= "ssh";
      prompt= "enabled";  # interactivity in gh
      pager= "less";
      aliases = {
        co = "pr checkout";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;

    settings = {
      git.paging = {
        useConfig = false;
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };
}