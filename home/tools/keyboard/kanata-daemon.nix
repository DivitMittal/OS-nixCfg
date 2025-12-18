{pkgs, ...}: {
  home.packages = [
    pkgs.customDarwin.kanata-daemon
  ];
}
