{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  cmake,
  openssl,
  dbus,
  fontconfig,
  makeBinaryWrapper,
  installShellFiles,
  writableTmpDirAsHomeHook,
  # Feature flags (custom defaults)
  withStreaming ? true,
  withDaemon ? true,
  withImage ? true,
  withFuzzy ? true,
  withNotify ? false,
  withSixel ? false,
  withMediaControl ? false,
  withAudioBackend ? "rodio",
  ...
}:
rustPlatform.buildRustPackage {
  pname = "spotify-player";
  version = "unstable-2025-12-24";

  src = fetchFromGitHub {
    owner = "aome510";
    repo = "spotify-player";
    rev = "506c3318e6b1d02d35aa0bfdef19e5f07df5812d";
    hash = "sha256-um9QfaFqdWrtubdA3VBskp7YLnLdDCRHRS3k8qeUXoI=";
  };

  cargoHash = "sha256-mJSFSUeVEBd1KohFG1/UPofnOHzVl5o4IayuvbRJUBM=";

  nativeBuildInputs = [
    pkg-config
    cmake
    rustPlatform.bindgenHook
    installShellFiles
    writableTmpDirAsHomeHook
    makeBinaryWrapper
  ];

  buildInputs = [
    openssl
    dbus
    fontconfig
  ];

  buildNoDefaultFeatures = true;

  buildFeatures =
    lib.optional withStreaming "streaming"
    ++ lib.optional withDaemon "daemon"
    ++ lib.optional withImage "image"
    ++ lib.optional withFuzzy "fzf"
    ++ lib.optional withNotify "notify"
    ++ lib.optional withSixel "sixel"
    ++ lib.optional withMediaControl "media-control"
    ++ lib.optional (withAudioBackend == "rodio") "rodio-backend"
    ++ lib.optional (withAudioBackend == "pulseaudio") "pulseaudio-backend"
    ++ lib.optional (withAudioBackend == "alsa") "alsa-backend";

  doCheck = false;

  meta = {
    description = "Terminal spotify player that has feature parity with the official client";
    homepage = "https://github.com/aome510/spotify-player";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [DivitMittal];
    mainProgram = "spotify_player";
  };
}
