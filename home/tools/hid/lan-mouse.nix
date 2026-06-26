{
  inputs,
  lib,
  hostPlatform,
  ...
}: {
  imports = [inputs.lan-mouse.homeManagerModules.default];

  programs.lan-mouse = {
    enable = true;
    package = inputs.lan-mouse.packages.${hostPlatform.system}.default.overrideAttrs (_: {
      buildInputs = [];
      cargoBuildFlags = ["--no-default-features"];
      cargoTestFlags = ["--no-default-features"];
    });
    systemd = true;
    launchd = true;
    settings = {
      port = 4242;
      release_bind = ["KeyLeftCtrl" "KeyLeftShift" "KeyEsc"];
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
