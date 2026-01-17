{
  lib,
  stdenvNoCC,
  fetchurl,
  ...
}: let
  version = "0.13.0";
  pname = "bv";

  sources = {
    "x86_64-linux" = {
      url = "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v${version}/bv_${version}_linux_amd64.tar.gz";
      hash = "sha256-8Ux9Brf2u78ljmTB49EBXCAn41WssOl8c+dZ1DZDjkw=";
    };
    "aarch64-linux" = {
      url = "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v${version}/bv_${version}_linux_arm64.tar.gz";
      hash = "sha256-dxkewC884pA0exBZFixC2A+VgTw5ZyirnD8Zj9ncAwg=";
    };
    "x86_64-darwin" = {
      url = "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v${version}/bv_${version}_darwin_amd64.tar.gz";
      hash = "sha256-n7+K0grNaNKDvrJurt25Ow3/2wuWVvrjp38fFWcPYfA=";
    };
    "aarch64-darwin" = {
      url = "https://github.com/Dicklesworthstone/beads_viewer/releases/download/v${version}/bv_${version}_darwin_arm64.tar.gz";
      hash = "sha256-eCA/NKQ7QT9KEEOtBiwOb9ksxj2k202ENK1tWKOdCEY=";
    };
  };

  platformSource = sources.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported platform: ${stdenvNoCC.hostPlatform.system}");
in
  stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchurl {
      inherit (platformSource) url hash;
    };

    sourceRoot = ".";

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      install -Dm755 bv $out/bin/bv

      runHook postInstall
    '';

    meta = {
      description = "Graph-aware task management TUI for beads projects";
      homepage = "https://github.com/Dicklesworthstone/beads_viewer";
      license = lib.licenses.mit;
      platforms = lib.attrNames sources;
      maintainers = with lib.maintainers; [DivitMittal];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = "bv";
    };
  }
