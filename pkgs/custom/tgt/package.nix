{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  fetchzip,
  pkg-config,
  openssl,
  zlib,
  cctools,
  writableTmpDirAsHomeHook,
}: let
  # Prebuilt tdlib from tdlib-rs v1.2.0 release (tdlib version 1.8.29)
  # Using prebuilt binaries because nixpkgs tdlib has build issues on macOS
  tdlibPrebuiltRaw = fetchzip {
    url = let
      base = "https://github.com/FedericoBruzzone/tdlib-rs/releases/download/v1.2.0";
      platform =
        if stdenv.hostPlatform.isDarwin
        then "macos"
        else "linux";
      arch =
        if stdenv.hostPlatform.isAarch64
        then "aarch64"
        else "x86_64";
    in "${base}/tdlib-1.8.29-${platform}-${arch}.zip";
    hash =
      if stdenv.hostPlatform.isDarwin
      then
        if stdenv.hostPlatform.isAarch64
        then "sha256-QaFhGrahWaiyi2mwyyU/6mjYdKKf6Z7X1fdmEaQ6e1s="
        else "sha256-BJYbCBVHMzhdWkFUbtzBSKa+hSXMaIKw9lQg4HTRM94="
      else if stdenv.hostPlatform.isAarch64
      then "sha256-r09yYXTcL68CHOldnZLbjRjQ25m7gpQT1l9mATQ6YsU="
      else "sha256-+Vb1qlpewrsQGrhy+WSDMYCTLIQI7kauLkocj6SLA60=";
  };

  # Patch the prebuilt tdlib to use Nix's libraries (macOS only)
  tdlibPrebuilt =
    if stdenv.hostPlatform.isDarwin
    then
      stdenv.mkDerivation {
        pname = "tdlib-prebuilt-patched";
        version = "1.8.29";
        src = tdlibPrebuiltRaw;

        nativeBuildInputs = [cctools];
        buildInputs = [openssl zlib];

        installPhase = ''
          mkdir -p $out
          cp -r * $out/

          # Patch the dylib to use Nix's OpenSSL and zlib
          for lib in $out/lib/libtdjson*.dylib; do
            if [ -f "$lib" ] && [ ! -L "$lib" ]; then
              install_name_tool -change /usr/local/opt/openssl@3/lib/libssl.3.dylib ${openssl.out}/lib/libssl.3.dylib "$lib" || true
              install_name_tool -change /usr/local/opt/openssl@3/lib/libcrypto.3.dylib ${openssl.out}/lib/libcrypto.3.dylib "$lib" || true
              install_name_tool -change /usr/local/opt/zlib/lib/libz.1.dylib ${zlib}/lib/libz.1.dylib "$lib" || true
            fi
          done
        '';
      }
    else tdlibPrebuiltRaw;
in
  rustPlatform.buildRustPackage {
    pname = "tgt";
    version = "0-unstable-2026-02-19";

    src = fetchFromGitHub {
      owner = "FedericoBruzzone";
      repo = "tgt";
      rev = "b165e1c6ff4801aab91664123ce52185a317521b";
      hash = "sha256-DhMGQ9Ar9b4HMMhSu6iLVOTi8t39rQ1914zKZPDJIhg=";
    };

    cargoHash = "sha256-BoSM0gIX85HaFmm8bP8Ve/UU9W7TQaSkw4vTWSr0IKU=";

    nativeBuildInputs = [
      pkg-config
      rustPlatform.bindgenHook
      writableTmpDirAsHomeHook
    ];

    buildInputs = [
      openssl
      zlib
    ];

    buildNoDefaultFeatures = true;
    buildFeatures = ["local-tdlib"];

    env = {
      OPENSSL_NO_VENDOR = true;
      LOCAL_TDLIB_PATH = "${tdlibPrebuilt}";
    };

    doCheck = false;

    meta = {
      description = "TUI for Telegram written in Rust";
      homepage = "https://github.com/FedericoBruzzone/tgt";
      license = with lib.licenses; [mit asl20];
      platforms = lib.platforms.unix;
      maintainers = with lib.maintainers; [DivitMittal];
      mainProgram = "tgt";
    };
  }
