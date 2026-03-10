{
  stdenvNoCC,
  fetchurl,
  lib,
  makeWrapper,
  _7zz,
  autoPatchelfHook,
  alsa-lib,
  libpulseaudio,
  pipewire,
  ...
}: let
  version = "7.64";
  verShort = builtins.replaceStrings ["."] [""] version;

  sources =
    lib.attrsets.optionalAttrs stdenvNoCC.hostPlatform.isLinux {
      x86_64-linux = {
        url = "https://www.reaper.fm/files/7.x/reaper${verShort}_linux_x86_64.tar.xz";
        hash = "sha256-mw2m/lTMDbg1gS2g998eNbAo9xb3GZ4zIvMRRNDz85k=";
      };
      i686-linux = {
        url = "https://www.reaper.fm/files/7.x/reaper${verShort}_linux_i686.tar.xz";
        hash = "sha256-ao0I4XH6SMkaNvaCqidl0RrpKJDNxvZV6dHHcg8Svpw=";
      };
      aarch64-linux = {
        url = "https://www.reaper.fm/files/7.x/reaper${verShort}_linux_aarch64.tar.xz";
        hash = "sha256-C5pQfztoC3+HcQeNbG2Tbe63PTWfTGHvNOlIhiVgDp4=";
      };
      armv7l-linux = {
        url = "https://www.reaper.fm/files/7.x/reaper${verShort}_linux_armv7l.tar.xz";
        hash = "sha256-q1Cuu9nlqDu2utOBy0o1H1XoiS7FPC84ADbfQO2AUKs=";
      };
    }
    // lib.attrsets.optionalAttrs stdenvNoCC.hostPlatform.isDarwin {
      x86_64-darwin = {
        url = "https://www.reaper.fm/files/7.x/reaper${verShort}_universal.dmg";
        hash = "sha256-S8FbuvCO7+uB0N7gFTYFDYOq2SllWgfAykUDumxMWvs=";
      };
      aarch64-darwin = {
        url = "https://www.reaper.fm/files/7.x/reaper${verShort}_universal.dmg";
        hash = "sha256-S8FbuvCO7+uB0N7gFTYFDYOq2SllWgfAykUDumxMWvs=";
      };
    };

  source =
    sources.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported platform: ${stdenvNoCC.hostPlatform.system}");
in
  stdenvNoCC.mkDerivation (_finalAttrs: {
    pname = "reaper";
    inherit version;

    src = fetchurl {
      inherit (source) url hash;
    };

    nativeBuildInputs =
      lib.optionals stdenvNoCC.hostPlatform.isLinux [autoPatchelfHook makeWrapper]
      ++ lib.optionals stdenvNoCC.hostPlatform.isDarwin [_7zz makeWrapper];

    buildInputs = lib.optionals stdenvNoCC.hostPlatform.isLinux [
      alsa-lib
      libpulseaudio
      pipewire
      stdenvNoCC.cc.cc.lib
    ];

    unpackPhase =
      if stdenvNoCC.hostPlatform.isLinux
      then ''
        tar -xf $src
      ''
      else ''
        7zz x -snld $src
      '';

    sourceRoot =
      if stdenvNoCC.hostPlatform.isLinux
      then "REAPER"
      else "REAPER_INSTALL_UNIVERSAL/REAPER.app";

    installPhase =
      if stdenvNoCC.hostPlatform.isLinux
      then ''
        runHook preInstall

        mkdir -p $out/opt/REAPER
        cp -r . $out/opt/REAPER/

        mkdir -p $out/bin
        makeWrapper $out/opt/REAPER/reaper $out/bin/reaper

        runHook postInstall
      ''
      else ''
        runHook preInstall

        mkdir -p "$out/Applications/REAPER.app"
        cp -R . "$out/Applications/REAPER.app"

        if [[ -e "$out/Applications/REAPER.app/Contents/MacOS/REAPER" ]]; then
          makeWrapper "$out/Applications/REAPER.app/Contents/MacOS/REAPER" "$out/bin/reaper"
        fi

        runHook postInstall
      '';

    meta = {
      description = "Digital Audio Workstation";
      homepage = "https://www.reaper.fm";
      license = lib.licenses.unfree;
      platforms = builtins.attrNames sources;
      maintainers = with lib.maintainers; [DivitMittal];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = "reaper";
    };
  })
