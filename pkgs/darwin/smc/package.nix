{
  lib,
  stdenv,
  sources,
}:
stdenv.mkDerivation {
  inherit (sources.smcFanControl) pname src version;

  postPatch = ''
    substituteInPlace smc-command/smc.c \
      --replace-fail 'sprintf(val->key, key);' 'snprintf(val->key, sizeof(val->key), "%s", key);' \
      --replace-fail 'sprintf(val.key, key);' 'snprintf(val.key, sizeof(val.key), "%s", key);'
  '';

  buildPhase = ''
    runHook preBuild

    clang \
      -arch x86_64 \
      -mmacosx-version-min=10.7 \
      -DCMD_TOOL_BUILD \
      -Wall \
      -framework IOKit \
      smc-command/smc.c \
      -o smc

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    install -m755 smc "$out/bin/smc"

    runHook postInstall
  '';

  meta = {
    description = "Apple System Management Control (SMC) CLI from smcFanControl";
    homepage = "https://github.com/hholtmann/smcFanControl";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = ["x86_64-darwin"];
    mainProgram = "smc";
  };
}
