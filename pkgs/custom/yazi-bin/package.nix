{
  stdenvNoCC,
  lib,
  unzip,
  autoPatchelfHook,
  installShellFiles,
  sources,
  ...
}: let
  system = stdenvNoCC.hostPlatform.system;

  rustTarget = {
    aarch64-darwin = "aarch64-apple-darwin";
    x86_64-darwin = "x86_64-apple-darwin";
    aarch64-linux = "aarch64-unknown-linux-gnu";
    x86_64-linux = "x86_64-unknown-linux-gnu";
  };

  selected =
    {
      aarch64-darwin = sources.yazi-bin-aarch64-darwin;
      x86_64-darwin = sources.yazi-bin-x86_64-darwin;
      aarch64-linux = sources.yazi-bin-aarch64-linux;
      x86_64-linux = sources.yazi-bin-x86_64-linux;
    }.${
      system
    } or (throw "yazi-bin: unsupported platform ${system}");
in
  stdenvNoCC.mkDerivation {
    pname = "yazi";
    version = lib.removePrefix "v" selected.version;

    inherit (selected) src;

    nativeBuildInputs =
      [unzip installShellFiles]
      ++ lib.optionals stdenvNoCC.hostPlatform.isLinux [autoPatchelfHook];

    buildInputs = lib.optionals stdenvNoCC.hostPlatform.isLinux [
      stdenvNoCC.cc.cc.lib
    ];

    sourceRoot = "yazi-${rustTarget.${system}}";

    installPhase = ''
      runHook preInstall

      install -Dm755 yazi $out/bin/yazi
      install -Dm755 ya   $out/bin/ya

      installShellCompletion --bash completions/yazi.bash completions/ya.bash
      installShellCompletion --zsh  completions/_yazi     completions/_ya
      installShellCompletion --fish completions/yazi.fish completions/ya.fish

      runHook postInstall
    '';

    meta = {
      description = "Blazing fast terminal file manager written in Rust";
      homepage = "https://yazi-rs.github.io";
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [DivitMittal];
      platforms = builtins.attrNames rustTarget;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = "yazi";
    };
  }
