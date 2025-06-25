{inputs, ...}: {
  imports = [inputs.pre-commit-hooks.flakeModule];

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
        check-merge-conflicts.enable = true;
        detect-private-keys.enable = false;
        mixed-line-endings.enable = false;
        fix-byte-order-marker.enable = true;
        trim-trailing-whitespace.enable = true;
      };
    };
  };
}
