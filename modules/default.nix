{self, ...}: {
  flake.homeManagerModules = {
    all = builtins.import ./home;
    default = self.outputs.homeManagerModules.all;

    # Individual modules for selective importing
    crush = builtins.import ./home/crush.nix;
    github-copilot = builtins.import ./home/github-copilot.nix;
    glow = builtins.import ./home/glow.nix;
    ov = builtins.import ./home/ov.nix;
    spicetify-cli = builtins.import ./home/spicetify-cli.nix;
    spotifyd = builtins.import ./home/spotifyd.nix;
    tidalcycles = builtins.import ./home/tidalcycles.nix;
    warpd = builtins.import ./home/warpd.nix;
    wiki-tui = builtins.import ./home/wiki-tui.nix;
  };

  flake.darwinModules = {
    all = builtins.import ./hosts/darwin;
    default = self.outputs.darwinModules.all;

    # Individual modules for selective importing
    kanata = builtins.import ./hosts/darwin/kanata.nix;
    kanata-tray = builtins.import ./hosts/darwin/kanata-tray.nix;
    spotifyd = builtins.import ./hosts/darwin/spotifyd.nix;
  };
}
