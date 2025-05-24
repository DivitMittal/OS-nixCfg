{self, ...}: {
  home-manager = {
    config = builtins.import ./conf;
    extraSpecialArgs = {
      inherit self;
    };
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
  };
}