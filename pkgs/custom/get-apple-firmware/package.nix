{
  stdenvNoCC,
  fetchurl,
  lib,
}:
stdenvNoCC.mkDerivation (final: {
  pname = "get-apple-firmware";
  version = "0fdb8b37d662eb00c9f0ea8a3a655206a483355c";

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
