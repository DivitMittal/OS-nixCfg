{
  stdenvNoCC,
  fetchurl,
  lib,
  ...
}: let
  version = "2.14.0.7";
  arch =
    if stdenvNoCC.hostPlatform.system == "aarch64-darwin"
    then "arm64"
    else "x86_64";

  plugin = fetchurl {
    url = "https://github.com/reaper-oss/sws/releases/download/v${version}/reaper_sws-${arch}.dylib";
    hash =
      {
        x86_64-darwin = "sha256-c0enRIXFN+dMDdxTQ3hFv0almTF0dfrSHILNigJp2Js=";
        aarch64-darwin = "sha256-jmuob0qslYhxiE2ShfTwY4RJAKBLJSUb+VBEM0sQPbo=";
      }.${
        stdenvNoCC.hostPlatform.system
      };
  };

  python64 = fetchurl {
    url = "https://github.com/reaper-oss/sws/releases/download/v${version}/sws_python64.py";
    hash = "sha256-GDlvfARg1g5oTH2itEug6Auxr9iFlPDdGueInGmHqSI=";
  };

  python32 = fetchurl {
    url = "https://github.com/reaper-oss/sws/releases/download/v${version}/sws_python32.py";
    hash = "sha256-np2r568csSdIS7VZHDASroZlXhpfxXwNn0gROTinWU4=";
  };
in
  stdenvNoCC.mkDerivation {
    pname = "reaper-sws-extension";
    inherit version;

    # fetchurl outputs are single files — skip the default unpack phase entirely
    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      install -D ${plugin}   "$out/UserPlugins/reaper_sws-${arch}.dylib"
      install -D ${python64} "$out/Scripts/sws_python64.py"
      install -D ${python32} "$out/Scripts/sws_python32.py"
      runHook postInstall
    '';

    meta = {
      description = "SWS/S&M Extension for REAPER";
      homepage = "https://www.sws-extension.org/";
      license = lib.licenses.mit;
      platforms = ["x86_64-darwin" "aarch64-darwin"];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      maintainers = with lib.maintainers; [DivitMittal];
    };
  }
