{
  lib,
  stdenv,
  sources,
}:
stdenv.mkDerivation {
  inherit (sources.VoltageShift) pname src version;

  buildPhase = ''
    runHook preBuild

    clang++ \
      -arch x86_64 \
      -std=gnu++11 \
      -mmacosx-version-min=10.12 \
      -include VoltageShift/VoltageShift-Prefix.pch \
      -framework IOKit \
      -framework Foundation \
      voltageshiftd/main.mm \
      -o voltageshiftd_bin

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    install -m755 voltageshiftd_bin "$out/bin/voltageshiftd"

    runHook postInstall
  '';

  meta = {
    description = "CPU undervolting and power management for Intel Macs (CLI only)";
    homepage = "https://github.com/asepms92/VoltageShift";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = ["x86_64-darwin"];
    mainProgram = "voltageshiftd";
  };
}
