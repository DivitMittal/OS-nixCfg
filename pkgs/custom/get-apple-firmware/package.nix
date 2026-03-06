{
  stdenvNoCC,
  fetchurl,
  lib,
}:
stdenvNoCC.mkDerivation (final: {
  pname = "get-apple-firmware";
  version = "2eff99d377aa7aad181aad4796b0184c73630f3b";

  src = fetchurl {
    url = "https://raw.github.com/t2linux/wiki/${final.version}/docs/tools/firmware.sh";
    hash = "sha256-uBTrw5Xf8Jh+PBdfiazLMifTeKcvsN1gTAutSUUiUM8=";
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
