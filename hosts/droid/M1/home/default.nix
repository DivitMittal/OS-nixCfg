{
  self,
  inputs,
  hostPlatform,
  ...
}: {
  home-manager = {
    config = builtins.import ./home.nix;
    extraSpecialArgs = {
      inherit self;
      inherit inputs;
      inherit hostPlatform;
      # lib is propogated by default
    };
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
  };
}
