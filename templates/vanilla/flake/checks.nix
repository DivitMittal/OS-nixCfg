{inputs, ...}: {
  imports = [inputs.git-hooks.flakeModule];

  perSystem.pre-commit = {
    check.enable = true;

    settings = {
      src = ../.;
      excludes = ["flake.lock"];
      default_stages = ["pre-commit"];
      hooks = {
        ## Formatting
        treefmt.enable = false;
        trim-trailing-whitespace.enable = true;
        mixed-line-endings.enable = false;

        check-added-large-files = {
          enable = true;
          excludes = [
            ## Images
            "\\.png"
            "\\.jpg"
            "\\.jpeg"
            "\\.svg"
            "\\.gif"
          ];
        };
        check-case-conflicts.enable = true;
        check-executables-have-shebangs.enable = true;
        check-shebang-scripts-are-executable.enable = true;

        fix-byte-order-marker.enable = true;
        check-merge-conflicts.enable = true;
        detect-private-keys.enable = true;
      };
    };
  };
}
