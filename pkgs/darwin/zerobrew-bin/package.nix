{
  lib,
  stdenvNoCC,
  sources,
}: let
  inherit (sources.zerobrew-zb-aarch64) version;
  platform = stdenvNoCC.hostPlatform.system;
  zb =
    {
      aarch64-darwin = sources.zerobrew-zb-aarch64.src;
      x86_64-darwin = sources.zerobrew-zb-x86_64.src;
    }.${
      platform
    };
  zbx =
    {
      aarch64-darwin = sources.zerobrew-zbx-aarch64.src;
      x86_64-darwin = sources.zerobrew-zbx-x86_64.src;
    }.${
      platform
    };
in
  stdenvNoCC.mkDerivation {
    pname = "zerobrew";
    inherit version;
    inherit zb zbx;
    dontUnpack = true;
    dontFixup = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp $zb $out/bin/zb
      cp $zbx $out/bin/zbx
      chmod +x $out/bin/*
      runHook postInstall
    '';
    meta = {
      description = "A 5-20x faster experimental Homebrew alternative";
      homepage = "https://github.com/lucasgelfond/zerobrew";
      license = lib.licenses.bsd3;
      maintainers = with lib.maintainers; [DivitMittal];
      platforms = ["aarch64-darwin" "x86_64-darwin"];
      sourceProvenance = with lib.sourceTypes; [lib.sourceTypes.binaryNativeCode];
      mainProgram = "zb";
    };
  }
