{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "warpd";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "atuan26";
    repo = "warpd";
    rev = "v${version}";
    hash = "sha256-ngWQdGKvHxng0C1LlmYHMWjcH4mzgrEFr6DvEa6LdUE=";
  };

  postPatch = ''
    # Fix duplicate symbol error (global size_t nr_boxes; in macos.h included by multiple TUs)
    sed -i 's/^size_t nr_boxes;$/extern size_t nr_boxes;/' src/platform/macos/macos.h
    sed -i '/^size_t nr_screens;$/a size_t nr_boxes;' src/platform/macos/screen.m
  '';

  makeFlags = [
    "DISABLE_X=1"
    "DISABLE_WAYLAND=1"
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/share/man/man1
    install -m644 files/warpd.1.gz $out/share/man/man1/
    install -m755 bin/warpd-${version}-osx $out/bin/warpd
    runHook postInstall
  '';

  meta = {
    description = "A modal keyboard-driven virtual pointer for macOS";
    longDescription = ''
      warpd is a modal keyboard-driven interface for mouse manipulation.
      It provides three modes:
      - Hint Mode: Jump to UI elements by selecting hints
      - Grid Mode: Navigate using a recursive grid
      - Normal Mode: Vim-like hjkl movement for precise cursor control
    '';
    homepage = "https://github.com/atuan26/warpd";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
    mainProgram = "warpd";
  };
}
