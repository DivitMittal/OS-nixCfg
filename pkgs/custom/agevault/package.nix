{
  lib,
  buildGoModule,
  sources,
}:
buildGoModule {
  pname = "agevault";
  version = lib.removePrefix "v" sources.agevault.version;

  inherit (sources.agevault) src;

  vendorHash = "sha256-jiSYg4+RLzezW1D1kWxmNoEn0rlbXRzU3BsK16aP0tw=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Directory encryption tool using age file encryption";
    homepage = "https://github.com/ndavd/agevault";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.unix;
    mainProgram = "agevault";
  };
}
