{self, ...}: {
  home-manager = {
    config = builtins.import ./home.nix;
    extraSpecialArgs = {
      inherit self;
    };
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
  };
}