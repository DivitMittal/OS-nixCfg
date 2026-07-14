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

    # tccutil's digest_check() only allowlists TCC.db schemas through macOS 14
    # (Sonoma); on newer macOS (15+/26) every command exits 1 ("unknown
    # structure"). Neutralize the gate so it opens the DB on any macOS. The
    # osx>=14 INSERT (17 columns) is unchanged — confirm it still matches on
    # Darwin 25 via: sudo sqlite3 "/Library/.../TCC.db" ".schema access"
    postPatch = ''
      substituteInPlace tccutil.py \
        --replace-fail 'if not (accessTableDigest ==' 'if False and not (accessTableDigest =='
    '';

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
