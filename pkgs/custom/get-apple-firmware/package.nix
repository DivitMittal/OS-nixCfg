{
  stdenvNoCC,
  fetchurl,
  lib,
}:
stdenvNoCC.mkDerivation (final: {
  pname = "get-apple-firmware";
  version = "11fc0a8d8cfb61affd0cb9d1ac245c1b6c16d3cd";

  src = fetchurl {
    url = "https://raw.github.com/t2linux/wiki/${final.version}/docs/tools/firmware.sh";
    hash = "sha256-wcHYqiW7XwieRszQ2XOPwTv714T0maqSRGbGkPBZlh4=";
  };

  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out/bin
    cp ${final.src} $out/bin/get-apple-firmware
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
})
