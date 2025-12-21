{
  stdenvNoCC,
  fetchurl,
  lib,
}:
stdenvNoCC.mkDerivation (final: {
  pname = "get-apple-firmware";
  version = "360156db52c013dbdac0ef9d6e2cebbca46b955b";

  src = fetchurl {
    url = "https://raw.github.com/t2linux/wiki/${final.version}/docs/tools/firmware.sh";
    hash = "sha256-IL7omNdXROG402N2K9JfweretTnQujY67wKKC8JgxBo=";
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
