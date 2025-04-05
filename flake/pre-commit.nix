{inputs, ...}: {
  imports = [
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem.pre-commit = {
    check.enable = true;

    settings = {
      src = ./.;
      excludes = ["flake.lock"];
      default_stages = ["pre-commit"];
      hooks = {
        treefmt.enable = true;
        check-added-large-files = {
          enable = true;
          excludes = [
            "\\.png"
            "\\.jpg"
          ];
        };

        check-case-conflicts.enable = true;
        check-executables-have-shebangs.enable = true;
        check-shebang-scripts-are-executable.enable = false; # many of the scripts in the config aren't executable because they don't need to be.
        check-merge-conflicts.enable = true;
        detect-private-keys.enable = true;
        fix-byte-order-marker.enable = true;
        mixed-line-endings.enable = false;
        trim-trailing-whitespace.enable = true;

        # ========== nix ==========
        alejandra.enable = true;
        deadnix = {
          enable = true;
          settings = {
            noLambdaArg = true;
          };
        };
        statix.enable = true;

        # ========== shellscripts ==========
        shfmt.enable = true;
        shellcheck.enable = true;
        end-of-file-fixer.enable = true;
      };
    };
  };
}
