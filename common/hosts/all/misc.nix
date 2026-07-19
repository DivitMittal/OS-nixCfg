{
  lib,
  config,
  pkgs,
  hostPlatform,
  ...
}: {
  networking.hostName = config.hostSpec.hostName;
  time.timeZone = "Asia/Calcutta";

  ## documentation
  documentation = {
    enable = true;
    info.enable = true;
    man.enable = true;
    doc.enable = false;
  };
  environment.extraOutputsToInstall = ["info"]; # "doc" "devdoc"

  fonts.packages = [pkgs.nerd-fonts.caskaydia-cove];

  environment.systemPackages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ## GNU
      bc
      gnugrep
      inetutils
      gawk
      which
      gzip
      wget
      gnupatch
      gnupg
      binutils
      gnumake
      groff
      indent
      ## uutils
      uutils-tar # gnutar
      uutils-sed # gnused
      uutils-coreutils-noprefix # coreutils
      uutils-diffutils # diffutils
      uutils-findutils # findutils
      ## Others
      zip
      unzip
      curl
      vim
      git
      ;
    # nixpkgs uutils-procps unconditionally adds systemd-minimal-libs to
    # buildInputs, but upstream (uutils/procps) has no systemd dependency —
    # it builds and runs on macOS without it. Strip the Linux-only lib on
    # darwin so the full procps toolset (free, pgrep, pkill, ps, top,
    # vmstat, w, watch, …) is available uniformly across platforms.
    uutils-procps = pkgs.uutils-procps.overrideAttrs (
      old:
        lib.optionalAttrs hostPlatform.isDarwin {
          buildInputs = lib.filter (x: lib.getName x != "systemd-minimal-libs") (old.buildInputs or []);
        }
    );
  };
}
