{
  stdenvNoCC,
  fetchurl,
  lib,
  makeWrapper,
  _7zz,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Perplexity";
  # Update version and hash when a new release drops;
  # retrieve hash via: nix-prefetch-url --type sha256 <url>
  version = "unstable";

  src = fetchurl {
    url = "https://macos-download.perplexity.ai/Perplexity.dmg";
    # NOTE: nix-prefetch-url returns 403 for automated fetches.
    # Get the hash manually:
    #   curl -L -A "Mozilla/5.0" https://macos-download.perplexity.ai/Perplexity.dmg -o /tmp/Perplexity.dmg
    #   nix hash file --type sha256 /tmp/Perplexity.dmg
    hash = "sha256-IPhnhMFwxNcz6ri4DfJGqn9RkPh//aFSQbjGQCKyvp8=";
  };

  nativeBuildInputs = [_7zz makeWrapper];

  unpackPhase = ''7zz x -snld $src'';

  sourceRoot = "${finalAttrs.pname}.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/${finalAttrs.pname}.app"
    cp -R . "$out/Applications/${finalAttrs.pname}.app"

    if [[ -e "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" ]]; then
      makeWrapper "$out/Applications/${finalAttrs.pname}.app/Contents/MacOS/${finalAttrs.pname}" "$out/bin/perplexity"
    fi

    runHook postInstall
  '';

  meta = {
    description = "Perplexity AI desktop app for macOS";
    homepage = "https://www.perplexity.ai";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    maintainers = with lib.maintainers; [DivitMittal];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    mainProgram = "perplexity";
  };
})
