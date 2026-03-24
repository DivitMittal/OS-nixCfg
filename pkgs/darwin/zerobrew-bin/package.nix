{
  lib,
  stdenvNoCC,
  fetchurl,
}: let
  version = "0.2.1";
  archSuffix =
    {
      aarch64-darwin = "arm64";
      x86_64-darwin = "x64";
    }
    .${
      stdenvNoCC.hostPlatform.system
    };
  hashes = {
    zb = {
      aarch64-darwin = "sha256-3ss9uE+XBI1VRVs0yppSolyIuJydfWL1nhMFALot8yM=";
      x86_64-darwin = "sha256-vGvJ4koxLCjGjuNI+0VVsQmJgh9cB1nu1zX5gB0SNow=";
    };
    zbx = {
      aarch64-darwin = "sha256-u5SxJz/8LxHPdIo4GUlHPGzeWwDTEo8XQ9TAsGryGXw=";
      x86_64-darwin = "sha256-uge/oEFDRAACrO/ffCvIJJoBtcyMskJvtrniXKa9hAI=";
    };
  };
  platform = stdenvNoCC.hostPlatform.system;
  fetchBinary = name:
    fetchurl {
      url = "https://github.com/lucasgelfond/zerobrew/releases/download/v${version}/${name}-darwin-${archSuffix}";
      hash = hashes.${name}.${platform};
      inherit name;
    };
in
  stdenvNoCC.mkDerivation {
    pname = "zerobrew";
    inherit version;

    zb = fetchBinary "zb";
    zbx = fetchBinary "zbx";

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
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = "zb";
    };
  }
