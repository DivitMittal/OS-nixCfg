{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    flakeCheck = false; # handled via pre-commit

    programs = {
      deadnix.enable = true;
      deno.enable = true;
      alejandra.enable = true;
      statix.enable = true;
      # typos.enable = true;
    };

    projectRootFile = "flake.nix";
  };
}