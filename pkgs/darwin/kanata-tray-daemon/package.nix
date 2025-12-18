{
  stdenvNoCC,
  lib,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "kanata-tray-daemon";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp kanata-tray-start $out/bin/kanata-tray-start
    cp kanata-tray-stop $out/bin/kanata-tray-stop
    chmod +x $out/bin/kanata-tray-start
    chmod +x $out/bin/kanata-tray-stop
  '';

  meta = {
    description = "Scripts to start/stop kanata-tray and Karabiner daemon as background processes on macOS";
    platforms = lib.platforms.darwin;
  };
}
