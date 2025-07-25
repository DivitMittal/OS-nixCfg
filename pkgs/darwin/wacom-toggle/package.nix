{
  stdenvNoCC,
  lib,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "wacom-toggle";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp wacom-enable $out/bin/wacom-enable
    cp wacom-disable $out/bin/wacom-disable
    chmod +x $out/bin/wacom-enable
    chmod +x $out/bin/wacom-disable
  '';

  meta = {
    description = "Scripts to enable or disable Wacom tablet services on macOS";
    platforms = lib.platforms.darwin;
  };
}