{ user, config, ... }:

{
  imports = [
    ./kanata-tray.nix
  ];

  services.kanata-tray = {
    enable = true;
    package = /${config.users.users.${user.username}.home}/.local/bin/kanata-tray; #impure
  };
}