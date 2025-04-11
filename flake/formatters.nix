{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    flakeCheck = false; # handled via pre-commit

    programs = {
      #typos.enable = true;
      ## Nix
      alejandra.enable = true;
      deadnix.enable = true;
      statix.enable = true;
      ## js
      deno.enable = true;
      ## Markdown
      prettier.enable = true;
    };

    projectRootFile = "flake.nix";
  };
}
