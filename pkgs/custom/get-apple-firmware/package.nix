{
  stdenvNoCC,
  sources,
  lib,
}:
stdenvNoCC.mkDerivation {
  inherit (sources.get-apple-firmware) pname version src;

  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out/bin
    cp ${sources.get-apple-firmware.src} $out/bin/get-apple-firmware
    chmod +x $out/bin/get-apple-firmware
  '';

  meta = {
    description = "A script to extract firmware from macOS for T2 Linux devices";
    homepage = "https://t2linux.org";
    license = lib.licenses.mit;
    maintainers = [];
    mainProgram = "get-apple-firmware";
    platforms = lib.platforms.linux;
  };
}
