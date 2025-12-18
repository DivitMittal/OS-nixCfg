{
  stdenvNoCC,
  lib,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "kanata-daemon";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp kanata-start $out/bin/kanata-start
    cp kanata-stop $out/bin/kanata-stop
    chmod +x $out/bin/kanata-start
    chmod +x $out/bin/kanata-stop
  '';

  meta = {
    description = "Scripts to start/stop kanata-tray and Karabiner daemon as background processes on macOS";
    platforms = lib.platforms.darwin;
  };
}
