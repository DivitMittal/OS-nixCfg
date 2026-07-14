{
  lib,
  stdenvNoCC,
  sources,
}:
stdenvNoCC.mkDerivation {
  pname = "yara-rules";
  version = sources.yara-rules.version;

  inherit (sources.yara-rules) src;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -R "$src"/. "$out"/
    runHook postInstall
  '';

  meta = {
    description = "Yara-Rules/rules community ruleset for malware hunting";
    homepage = "https://github.com/Yara-Rules/rules";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
