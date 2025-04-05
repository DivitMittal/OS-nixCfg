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
        treefmt.enable = false;
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
        mixed-line-endings.enable = false;

        fix-byte-order-marker.enable = true;
        trim-trailing-whitespace.enable = true;
      };
    };
  };
}