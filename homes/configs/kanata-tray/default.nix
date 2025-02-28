{ config, pkgs, ... }:

{
  home.file.kanata-tray = {
    enable = true;
    text = ''
      '$schema' = 'https://raw.githubusercontent.com/rszyma/kanata-tray/main/doc/config_schema.json'

      [general]
      allow_concurrent_presets = false

      [defaults]
      kanata_executable = '${pkgs.kanata-with-cmd}/bin/kanata' # if empty or omitted, system $PATH will be searched.
      tcp_port = 5830 # if not specified, defaults to 5829

      # [defaults.hooks]
      # Hooks allow running custom commands on specific events (e.g. starting preset).
      # Documentation: https://github.com/rszyma/kanata-tray/blob/main/doc/hooks.md

      # [defaults.layer_icons]
      # mouse = 'mouse.png'
      # qwerty = 'qwerty.ico'
      # '*' = 'other_layers.ico'

      [presets.'TLTR']
      kanata_config = '${config.xdg.configHome}/kanata/kanata.kbd'
      autorun = true
      layer_icons = { }
      extra_args = ['-n']
    '';
    target = "${config.home.homeDirectory}/Library/Application Support/kanata-tray/kanata-tray.toml";
  };
}