{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "agevault";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "ndavd";
    repo = "agevault";
    rev = "v${version}";
    hash = "sha256-f7t/hzBfZi3OJtYPM4n5bDhm+LcceinDUZIpVsSSl/s=";
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
