{
  lib,
  stdenvNoCC,
  sources,
  ...
}: let
  platform = stdenvNoCC.hostPlatform.system;
  sourcesByPlatform = {
    aarch64-darwin = sources.uniclipboard-cli-aarch64-darwin;
    x86_64-darwin = sources.uniclipboard-cli-x86_64-darwin;
    aarch64-linux = sources.uniclipboard-cli-aarch64-linux;
    x86_64-linux = sources.uniclipboard-cli-x86_64-linux;
  };
  source =
    sourcesByPlatform.${platform}
    or (throw "Unsupported platform: ${platform}");
in
  stdenvNoCC.mkDerivation {
    pname = "uniclipboard-cli";
    inherit (source) version;
    inherit (source) src;

    dontFixup = true;
    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp uniclip $out/bin/uniclip
      cp uniclipd $out/bin/uniclipd
      chmod +x $out/bin/uniclip $out/bin/uniclipd

      runHook postInstall
    '';

    meta = {
      description = "CLI binaries for UniClipboard";
      homepage = "https://github.com/UniClipboard/UniClipboard";
      license = lib.licenses.agpl3Only;
      maintainers = with lib.maintainers; [DivitMittal];
      platforms = builtins.attrNames sourcesByPlatform;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = "uniclip";
    };
  }
