{
  lib,
  stdenvNoCC,
  sources,
}:
stdenvNoCC.mkDerivation {
  pname = "clamav-unofficial-sigs";
  version = sources.clamav-unofficial-sigs.version;

  inherit (sources.clamav-unofficial-sigs) src;

  dontConfigure = true;
  dontBuild = true;

  # The upstream is a single bash script (~200KB) plus a `config/` tree with
  # `master.conf`, `user.conf`, and OS-specific overrides. Install the
  # script into `$out/bin` and the configs next to it under `$out/share`,
  # so a user can either:
  #   1. run `clamav-unofficial-sigs.sh` directly against the bundled
  #      configs (pointing it at `$out/share/.../config/master.conf`),
  #   2. or copy the configs elsewhere and edit them.
  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin" "$out/share/clamav-unofficial-sigs"
    cp clamav-unofficial-sigs.sh "$out/bin/clamav-unofficial-sigs.sh"
    chmod +x "$out/bin/clamav-unofficial-sigs.sh"
    cp -R config "$out/share/clamav-unofficial-sigs/"
    runHook postInstall
  '';

  meta = {
    description = "Download, test, and update third-party ClamAV signature databases (Sanesecurity, MalwarePatrol, URLhaus, …)";
    homepage = "https://github.com/extremeshok/clamav-unofficial-sigs";
    license = lib.licenses.bsd2;
    platforms = lib.platforms.unix;
    mainProgram = "clamav-unofficial-sigs.sh";
  };
}
