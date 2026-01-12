_: {
  homebrew = {
    taps = [
      "macos-fuse-t/homebrew-cask" #fuse-t
    ];
    casks = [
      "fuse-t" #"macfuse"
      "veracrypt-fuse-t"
    ];
  };

  # Create symlink for fuse-t compatibility with sshfs
  # fuse-t is installed via homebrew as a drop-in replacement for macfuse
  # but sshfs looks for libfuse.2.dylib, so we create a symlink
  system.activationScripts.extraActivation.text = ''
    # Check if fuse-t library exists and create symlink if needed
    FUSE_T_LIB="/usr/local/lib/libfuse-t.dylib"
    FUSE_SYMLINK="/usr/local/lib/libfuse.2.dylib"

    if [ -f "$FUSE_T_LIB" ] && [ ! -e "$FUSE_SYMLINK" ]; then
      echo "Creating fuse-t compatibility symlink..."
      ln -sf "$FUSE_T_LIB" "$FUSE_SYMLINK"
    fi
  '';
}
