{ inputs, ... }:

{
  imports = [
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem.pre-commit = {
    check.enable = true;

    settings = {
      excludes = ["flake.lock"];
      hooks = {
        nixfmt-rfc-style.enable = true;
        deadnix.enable = true;
        nil.enable = true;
        statix.enable = true;
      };
    };
  };
}