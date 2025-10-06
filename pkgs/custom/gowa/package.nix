{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "gowa";
  version = "7.7.0";

  src = fetchFromGitHub {
    owner = "aldinokemal";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-oVi0ibFEXEALGHk0IONrMSwPFMhFuJ80vSsL3dL1dd0=";
  };

  sourceRoot = "${src.name}/src";

  vendorHash = "sha256-Im+UEV1klTRoQjiWcO8V9XG3zwU/siY0vIKW3Nz+bR0=";

  ldflags = ["-s" "-w" "-X github.com/aldinokemal/go-whatsapp-web-multidevice/config.AppVersion=${version}"];

  # The application embeds view files, so we need to ensure they're available
  preBuild = ''
    # Ensure embedded files are in the right place
    ls -la views/ || echo "Views directory check"
  '';

  postInstall = ''
    mv $out/bin/go-whatsapp-web-multidevice $out/bin/gowa
  '';

  meta = {
    description = "WhatsApp REST API with support for UI, Webhooks, and MCP. Built with Golang for efficient memory use";
    homepage = "https://github.com/aldinokemal/go-whatsapp-web-multidevice";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [DivitMittal];
    platforms = lib.platforms.unix;
    mainProgram = "gowa";
  };
}
