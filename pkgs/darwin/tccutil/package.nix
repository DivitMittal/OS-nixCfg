{
  lib,
  python3,
  stdenvNoCC,
  sources,
}: let
  python = python3.withPackages (ps: [ps.packaging]);
in
  stdenvNoCC.mkDerivation {
    inherit (sources.tccutil) pname version src;

    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      install -m755 tccutil.py $out/bin/tccutil
      substituteInPlace $out/bin/tccutil \
        --replace-fail '#!/usr/bin/env python' '#!${python}/bin/python3'
      runHook postInstall
    '';

    meta = {
      description = "Utility to modify the macOS TCC database (accessibility/privacy permissions)";
      homepage = "https://github.com/jacobsalmela/tccutil";
      license = lib.licenses.gpl2Plus;
      maintainers = with lib.maintainers; [DivitMittal];
      platforms = lib.platforms.darwin;
      mainProgram = "tccutil";
    };
  }
