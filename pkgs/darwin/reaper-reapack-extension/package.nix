{
  stdenvNoCC,
  lib,
  sources,
  ...
}: let
  inherit (sources.reapack-arm64) version; # same for both arches
  plugin =
    {
      aarch64-darwin = sources.reapack-arm64.src;
      x86_64-darwin = sources.reapack-x86_64.src;
    }.${
      stdenvNoCC.hostPlatform.system
    };
  arch =
    if stdenvNoCC.hostPlatform.system == "aarch64-darwin"
    then "arm64"
    else "x86_64";
in
  stdenvNoCC.mkDerivation {
    pname = "reaper-reapack-extension";
    inherit version;
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
      sourceProvenance = with lib.sourceTypes; [lib.sourceTypes.binaryNativeCode];
      maintainers = with lib.maintainers; [DivitMittal];
    };
  }
