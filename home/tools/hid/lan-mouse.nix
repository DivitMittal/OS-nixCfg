{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.lan-mouse.homeManagerModules.default];

  programs.lan-mouse = {
    enable = true;
    systemd = true;
    launchd = true;
    settings = {
      port = 4242;
      release_bind = ["KeyLeftCtrl" "KeyEsc"];
      clients = [
        {
          position = "top";
          ips = ["192.168.77.2"];
          port = 4242;
        }
      ];
    };
  };

  # Service defined but not auto-started — start manually via systemctl/launchctl
  systemd.user.services.lan-mouse.Install.WantedBy = lib.mkForce [];
  launchd.agents.lan-mouse.config.RunAtLoad = lib.mkForce false;
}
