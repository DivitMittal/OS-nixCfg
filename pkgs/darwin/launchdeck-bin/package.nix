{
  lib,
  stdenvNoCC,
  sources,
  ...
}: let
  inherit (sources.launchdeck-aarch64) version;
  platform = stdenvNoCC.hostPlatform.system;
  src =
    {
      aarch64-darwin = sources.launchdeck-aarch64.src;
      x86_64-darwin = sources.launchdeck-x86_64.src;
    }.${
      platform
    };
in
  stdenvNoCC.mkDerivation {
    pname = "launchdeck";
    inherit version src;

    dontFixup = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp launchdeck $out/bin/launchdeck
      chmod +x $out/bin/launchdeck
      runHook postInstall
    '';

    meta = {
      description = "Unified macOS service console for launchd and Homebrew";
      homepage = "https://github.com/sderosiaux/launchdeck";
      license = lib.licenses.asl20;
      maintainers = with lib.maintainers; [DivitMittal];
      platforms = ["aarch64-darwin" "x86_64-darwin"];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = "launchdeck";
    };
  }
