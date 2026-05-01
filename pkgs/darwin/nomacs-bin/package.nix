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
  version = "3.22.1";

  src = fetchurl {
    url = "https://github.com/nomacs/nomacs/releases/download/3.22.1/nomacs-3.22.1-8f3dff6f-macOS-15.7.5-x86_64-quazip-qt6.zip";
    hash = "sha256-hSHYQvXNuyuhikzMcGd61Tk5KdVJw3Za2wyBkT74sVo=";
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
