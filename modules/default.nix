{self, ...}: {
  flake.homeManagerModules = {
    all = import ./home;
    default = self.outputs.homeManagerModules.all;

    # Individual modules for selective importing
    crush = import ./home/crush.nix;
    github-copilot = import ./home/github-copilot.nix;
    glow = import ./home/glow.nix;
    ov = import ./home/ov.nix;
    spicetify-cli = import ./home/spicetify-cli.nix;
    spotifyd = import ./home/spotifyd.nix;
    tidalcycles = import ./home/tidalcycles.nix;
    warpd = import ./home/warpd.nix;
    wiki-tui = import ./home/wiki-tui.nix;
  };

  flake.darwinModules = {
    all = import ./hosts/darwin;
    default = self.outputs.darwinModules.all;

    # Individual modules for selective importing
    kanata = import ./hosts/darwin/kanata.nix;
    kanata-tray = import ./hosts/darwin/kanata-tray.nix;
    spotifyd = import ./hosts/darwin/spotifyd.nix;
  };
}
