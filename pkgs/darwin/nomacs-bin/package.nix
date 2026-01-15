{
  stdenvNoCC,
  fetchurl,
  lib,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  pname = "nomacs";
  version = "3.22.0";

  src = fetchurl {
    url = "https://github.com/nomacs/nomacs/releases/download/3.22.0/nomacs-3.22.0-macOS-x86_64.zip";
    hash = "sha256-iKNLHdkgtdP2bdpGbwVXEvmXtODA7OT7Go/2DWhWGo0=";
  };

  nativeBuildInputs = [unzip makeWrapper];

  # The outer zip contains nomacs.app.zip, which we need to extract
  unpackPhase = ''
    runHook preUnpack
    unzip -q $src
    unzip -q nomacs.app.zip
    runHook postUnpack
  '';

  sourceRoot = "nomacs.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/nomacs.app"
    cp -R . "$out/Applications/nomacs.app"

    if [[ -e "$out/Applications/nomacs.app/Contents/MacOS/nomacs" ]]; then
      makeWrapper "$out/Applications/nomacs.app/Contents/MacOS/nomacs" "$out/bin/nomacs"
    fi

    runHook postInstall
  '';

  meta = {
    description = "Free image viewer for windows, linux, and mac systems";
    homepage = "https://github.com/nomacs/nomacs";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "nomacs";
  };
})
