{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    settings.global = {
      excludes = [
        ".github/*"
      ];
    };

    flakeCheck = false; # handled via pre-commit

    programs = {
      #typos.enable = true;
      ## Nix
      alejandra.enable = true;
      deadnix.enable = true;
      statix.enable = true;
      ## js & markdown
      prettier.enable = true;
      ## Shell-scripts
      shfmt.enable = true;
    };
  };
}
