{self, ...}: let
  # Helper function to import a module - slightly more efficient than repeated builtins.import
  # as it provides a clear pattern and can be optimized by Nix's evaluation cache
  importModule = path: builtins.import path;
in {
  flake.homeManagerModules = {
    all = importModule ./home;
    default = self.outputs.homeManagerModules.all;

    # Individual modules for selective importing
    crush = importModule ./home/crush.nix;
    github-copilot = importModule ./home/github-copilot.nix;
    glow = importModule ./home/glow.nix;
    ov = importModule ./home/ov.nix;
    spicetify-cli = importModule ./home/spicetify-cli.nix;
    spotifyd = importModule ./home/spotifyd.nix;
    tidalcycles = importModule ./home/tidalcycles.nix;
    warpd = importModule ./home/warpd.nix;
    wiki-tui = importModule ./home/wiki-tui.nix;
  };

  flake.darwinModules = {
    all = importModule ./hosts/darwin;
    default = self.outputs.darwinModules.all;

    # Individual modules for selective importing
    kanata = importModule ./hosts/darwin/kanata.nix;
    kanata-tray = importModule ./hosts/darwin/kanata-tray.nix;
    spotifyd = importModule ./hosts/darwin/spotifyd.nix;
  };
}
