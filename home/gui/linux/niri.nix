{inputs, ...}: {
  imports = [inputs.niri-flake.homeModules.niri];

  programs.niri = {
    enable = true;
  };
}
