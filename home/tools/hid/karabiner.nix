{inputs, ...}: {
  xdg.configFile."karabiner" = {
    enable = false;
    source = inputs.TLTR + "/karabiner";
    recursive = true;
  };
}
