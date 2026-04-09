{
  lib,
  stdenvNoCC,
  stdenv,
  fetchurl,
  sources,
  ...
}: let
  version = lib.removePrefix "V" sources.mole.version;

  binaries = {
    aarch64-darwin = {
      analyze = fetchurl {
        url = "https://github.com/tw93/Mole/releases/download/V${version}/analyze-darwin-arm64";
        hash = "sha256-LRg9Pn07DNdJ/Bn2hJqnOqRDnczUgCfl+1xTbMG/5DA=";
      };
      status = fetchurl {
        url = "https://github.com/tw93/Mole/releases/download/V${version}/status-darwin-arm64";
        hash = "sha256-eAVY30y+xUBM9EJzVq/3v34s6uXZp3JMYrjpbkYBXJQ=";
      };
    };
    x86_64-darwin = {
      analyze = fetchurl {
        url = "https://github.com/tw93/Mole/releases/download/V${version}/analyze-darwin-amd64";
        hash = "sha256-ywQGtgx4eQ+6Gmvho8/kl16Fjyw3jdQpdTqL02jobGE=";
      };
      status = fetchurl {
        url = "https://github.com/tw93/Mole/releases/download/V${version}/status-darwin-amd64";
        hash = "sha256-3ZOIFaKXmVMR6aTBKnT9pI+Gm8pz/lf5m4FaepsYIyI=";
      };
    };
  };

  platformBinaries = binaries.${stdenv.hostPlatform.system} or (throw "Unsupported platform: ${stdenv.hostPlatform.system}");
in
  stdenvNoCC.mkDerivation {
    pname = "mole";
    inherit version;

    inherit (sources.mole) src;

    # Fix bash arithmetic bug: ((var++)) returns exit code 1 when var=0
    # which causes early exit with set -e. Using : $((var++)) always succeeds.
    postPatch = ''
      find . -name '*.sh' -exec sed -i 's/((\([a-z_]*\)++))/: $((\1++))/g' {} +
    '';

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      # Install main executables to bin
      mkdir -p $out/bin
      cp mole mo $out/bin/
      chmod +x $out/bin/mole $out/bin/mo

      # Install lib and bin directories to share/mole
      mkdir -p $out/share/mole
      cp -r lib bin $out/share/mole/
      chmod +x $out/share/mole/bin/*.sh

      # Install Go binaries (analyze and status)
      install -m755 ${platformBinaries.analyze} $out/share/mole/bin/analyze-go
      install -m755 ${platformBinaries.status} $out/share/mole/bin/status-go

      # Patch the mole script to use the correct SCRIPT_DIR
      substituteInPlace $out/bin/mole \
        --replace-fail 'SCRIPT_DIR="$(cd "$(dirname "''${BASH_SOURCE[0]}")" && pwd)"' \
                       'SCRIPT_DIR="'"$out/share/mole"'"'

      runHook postInstall
    '';

    meta = {
      description = "Deep clean and optimize your Mac";
      homepage = "https://github.com/tw93/Mole";
      license = lib.licenses.mit;
      platforms = lib.platforms.darwin;
      maintainers = with lib.maintainers; [DivitMittal];
      mainProgram = "mo";
    };
  }
