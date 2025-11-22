{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "warpd";
  version = "1.3.5";

  src = fetchFromGitHub {
    owner = "rvaiya";
    repo = "warpd";
    rev = "v${version}";
    hash = "sha256-YHTQ5N4SZSa3S3sy/lNjarKPkANIuB2khwyOW5TW2vo=";
  };

  postPatch = ''
        # Fix duplicate symbol error
        sed -i 's/^size_t nr_boxes;$/extern size_t nr_boxes;/' src/platform/macos/macos.h
        sed -i '/^size_t nr_screens;$/a size_t nr_boxes;' src/platform/macos/screen.m

        # Remove codesign step (not available in Nix sandbox)
        sed -i '/\.\/codesign\/sign.sh/d' mk/macos.mk

        # Replace the entire install target with a simpler Nix-friendly version
        cat >> mk/macos.mk << 'EOF'

    install:
    	mkdir -p $(PREFIX)/bin $(PREFIX)/share/man/man1
    	install -m644 files/warpd.1.gz $(PREFIX)/share/man/man1/
    	install -m755 bin/warpd $(PREFIX)/bin/
    EOF
  '';

  # Disable X11 and Wayland support on macOS
  makeFlags = [
    "PREFIX=$(out)"
    "DISABLE_X=1"
    "DISABLE_WAYLAND=1"
  ];

  meta = {
    description = "A modal keyboard-driven virtual pointer for macOS";
    longDescription = ''
      warpd is a modal keyboard-driven interface for mouse manipulation.
      It provides three modes:
      - Hint Mode: Jump to UI elements by selecting hints
      - Grid Mode: Navigate using a recursive grid
      - Normal Mode: Vim-like hjkl movement for precise cursor control
    '';
    homepage = "https://github.com/rvaiya/warpd";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.darwin;
    mainProgram = "warpd";
  };
}
