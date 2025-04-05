{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    flakeCheck = false; # handled via pre-commit

    programs = {
      alejandra.enable = true;
      deadnix.enable = true;
      statix.enable = true;

      deno.enable = true;
      # typos.enable = true;
    };

    projectRootFile = "flake.nix";
  };
}