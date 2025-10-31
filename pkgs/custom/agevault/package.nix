{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  pname = "agevault";
  version = "unstable-2024-11-30";

  src = fetchFromGitHub {
    owner = "ndavd";
    repo = "agevault";
    rev = "main";
    hash = "sha256-Rqh/PVWB2qj3PPz+UwIznRrjJw529dpLnTqIOdxvOTU=";
  };

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
