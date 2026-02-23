{
  stdenvNoCC,
  fetchurl,
  lib,
  makeWrapper,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  pname = "betterdiscord";
  version = "1.3.0";

  src = fetchurl {
    url = "https://github.com/BetterDiscord/Installer/releases/download/v${_finalAttrs.version}/BetterDiscord-Mac.zip";
    hash = "sha256-hb3XtE+WJPd0CvTSZoLyFzDEemQ/3gCfKtdmr6GTVrg=";
  };

  nativeBuildInputs = [unzip makeWrapper];

  sourceRoot = "BetterDiscord.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/BetterDiscord.app"
    cp -R . "$out/Applications/BetterDiscord.app"

    mkdir -p "$out/bin"
    makeWrapper "$out/Applications/BetterDiscord.app/Contents/MacOS/BetterDiscord" "$out/bin/betterdiscord"

    runHook postInstall
  '';

  meta = {
    description = "Installer for BetterDiscord, a client modification for Discord";
    homepage = "https://betterdiscord.app";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "betterdiscord";
  };
})
