{
  pkgs,
  lib,
  config,
  hostPlatform,
  inputs,
  ...
}: {
  home.packages = lib.attrsets.attrValues {
    inherit
      (pkgs)
      ## Android
      android-tools
      scrcpy
      ## General
      tokei
      ## Programming Languages
      #tree-sitter
      ## java
      #jdk gradle
      ## lua
      lua
      ## Rust (cargo binary - config managed by programs.cargo below)
      cargo
      ## macOS
      xcodes
      ;

    leetcode-tui = inputs.leetcode-tui.packages.${hostPlatform.system}.default;
  };

  ## Rust
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
