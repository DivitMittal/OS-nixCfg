{
  stdenvNoCC,
  lib,
  sources,
  ...
}: let
  inherit (sources.reaper-sws-arm64) version;
  arch =
    if stdenvNoCC.hostPlatform.system == "aarch64-darwin"
    then "arm64"
    else "x86_64";
  plugin =
    {
      aarch64-darwin = sources.reaper-sws-arm64.src;
      x86_64-darwin = sources.reaper-sws-x86_64.src;
    }.${
      stdenvNoCC.hostPlatform.system
    };
in
  stdenvNoCC.mkDerivation {
    pname = "reaper-sws-extension";
    inherit version;
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      install -D ${plugin}                          "$out/UserPlugins/reaper_sws-${arch}.dylib"
      install -D ${sources.reaper-sws-python64.src} "$out/Scripts/sws_python64.py"
      install -D ${sources.reaper-sws-python32.src} "$out/Scripts/sws_python32.py"
      runHook postInstall
    '';
    meta = {
      description = "SWS/S&M Extension for REAPER";
      homepage = "https://www.sws-extension.org/";
      license = lib.licenses.mit;
      platforms = ["x86_64-darwin" "aarch64-darwin"];
      sourceProvenance = with lib.sourceTypes; [lib.sourceTypes.binaryNativeCode];
      maintainers = with lib.maintainers; [DivitMittal];
    };
  }
