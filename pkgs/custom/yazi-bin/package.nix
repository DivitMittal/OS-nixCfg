{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "yazi";
  version = "25.12.29";

  src = let
    platform =
      {
        "x86_64-darwin" = "x86_64-apple-darwin";
        "aarch64-darwin" = "aarch64-apple-darwin";
        "x86_64-linux" = "x86_64-unknown-linux-musl";
        "aarch64-linux" = "aarch64-unknown-linux-musl";
      }
      .${
        stdenvNoCC.hostPlatform.system
      };
    hash =
      {
        "x86_64-darwin" = "sha256-dp0YAS5r3y1VnrCjirJaeglcgLfNfxCJQSdk7Wd1aoU=";
        "aarch64-darwin" = "sha256-byp4KKEBmEv8vK8RikKxHBqeQgEwlKrid+LBun+OfFY=";
        "x86_64-linux" = "sha256-2yQ2iIoqdhsHknwnDr6nLKRlCzs8wlX/MEP+VXQ/xFU=";
        "aarch64-linux" = "sha256-dKWoZuc/VAzb0R4Drpn4KPsCynjM4M6ZF3OBz4yKU00=";
      }
      .${
        stdenvNoCC.hostPlatform.system
      };
  in
    fetchzip {
      url = "https://github.com/sxyazi/yazi/releases/download/v${finalAttrs.version}/yazi-${platform}.zip";
      inherit hash;
    };

  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/doc/yazi
    cp ./yazi $out/bin/
    cp ./ya $out/bin/
    chmod +x $out/bin/yazi $out/bin/ya

    # Install completions if present
    if [ -d ./completions ]; then
      mkdir -p $out/share/fish/vendor_completions.d
      mkdir -p $out/share/zsh/site-functions
      mkdir -p $out/share/bash-completion/completions
      cp -r ./completions/yazi.fish $out/share/fish/vendor_completions.d/ 2>/dev/null || true
      cp -r ./completions/_yazi $out/share/zsh/site-functions/ 2>/dev/null || true
      cp -r ./completions/yazi.bash $out/share/bash-completion/completions/yazi 2>/dev/null || true
    fi

    runHook postInstall
  '';

  meta = {
    description = "Blazing fast terminal file manager written in Rust, based on async I/O";
    homepage = "https://github.com/sxyazi/yazi";
    changelog = "https://github.com/sxyazi/yazi/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = ["x86_64-darwin" "aarch64-darwin" "x86_64-linux" "aarch64-linux"];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "yazi";
  };
})
