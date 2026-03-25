{
  stdenvNoCC,
  fetchurl,
  lib,
  ...
}: let
  version = "1.2.6";
  arch =
    if stdenvNoCC.hostPlatform.system == "aarch64-darwin"
    then "arm64"
    else "x86_64";

  plugin = fetchurl {
    url = "https://github.com/cfillion/reapack/releases/download/v${version}/reaper_reapack-${arch}.dylib";
    hash =
      {
        x86_64-darwin = "sha256-SLJhl042ZxOEypAqOz1aYUF49Asb63wTjHQUEOpdfZ4=";
        aarch64-darwin = "sha256-x2cPOy5AW5A31JsZQaTYw3Yv/zJs7MDFisT67KFx8Hs=";
      }.${
        stdenvNoCC.hostPlatform.system
      };
  };
in
  stdenvNoCC.mkDerivation {
    pname = "reaper-reapack-extension";
    inherit version;

    # fetchurl outputs are single files — skip the default unpack phase entirely
    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      install -D ${plugin} "$out/UserPlugins/reaper_reapack-${arch}.dylib"
      runHook postInstall
    '';

    meta = {
      description = "Package manager for REAPER";
      homepage = "https://reapack.com/";
      license = with lib.licenses; [lgpl3Plus gpl3Plus];
      platforms = ["x86_64-darwin" "aarch64-darwin"];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      maintainers = with lib.maintainers; [DivitMittal];
    };
  }
