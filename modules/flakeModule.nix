_: {
  flake.homeManagerModules = {
    default = import ./home;
  };

  flake.darwinModules = {
    default = import ./hosts/darwin;
  };
}