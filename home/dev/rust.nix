{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      cargo
      ;
  };
  home.sessionPath = lib.mkAfter ["${config.home.homeDirectory}/.cargo/bin"];

  programs.cargo = {
    enable = true;
    settings = {
      # Build settings
      build = {
        jobs = 8; # Parallel compilation jobs
        incremental = true; # Enable incremental compilation
      };

      # Use sparse registry protocol for faster index updates
      registries.crates-io = {
        protocol = "sparse";
      };

      # Network settings
      net = {
        retry = 3; # Retry failed network operations
        git-fetch-with-cli = true; # Use git CLI for better credential handling
      };

      # Term settings
      term = {
        color = "auto"; # Colored output
        progress = {
          when = "auto";
          width = 80;
        };
      };
    };
  };
}
