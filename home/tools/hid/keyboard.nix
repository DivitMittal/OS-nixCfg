{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [pkgs.kanata-with-cmd];

  xdg.configFile."karabiner" = {
    enable = false;
    source = inputs.TLTR + "/karabiner";
    recursive = true;
  };
}
