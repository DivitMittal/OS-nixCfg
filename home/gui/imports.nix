{inputs, ...}: {
  imports = [
    # GUI/emulator profile: wezterm, kitty, ghostty, macOS Terminal.app.
    # Mirrors home/tty/imports.nix (which pulls the tty profile). kitty & ghostty
    # ship disabled-by-default — enable per-host here or in a host override.
    inputs.term-nixCfg.homeManagerConfigurations.gui
  ];
}
