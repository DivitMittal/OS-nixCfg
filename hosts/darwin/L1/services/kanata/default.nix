_:

{
  imports = [
    ./kanata-tray.nix
  ];

  services.kanata-tray = {
    enable = true;
  };
}