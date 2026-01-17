{
  pkgs,
  config,
  ...
}: {
  programs.fabric-ai = {
    enable = true;
    package = pkgs.fabric-ai;

    enableBashIntegration = false;
    enableZshIntegration = config.programs.zsh.enable;
    enablePatternsAliases = false;
    enableYtAlias = false;
  };
}
