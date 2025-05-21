{self, ...}: {
  flake.homeManagerModules = {
    all = builtins.import ./home;
    default = self.outputs.homeManagerModules.all;

    ai-chat = builtins.import ./home/aichat.nix;
    glow = builtins.import ./home/glow.nix;
    spicetify-cli = builtins.import ./home/spicetify-cli.nix;
  };

  flake.darwinModules = {
    all = builtins.import ./hosts/darwin;
    default = self.outputs.darwinModules.all;

    kanata = builtins.import ./hosts/darwin/kanata.nix;
    kanata-tray = builtins.import ./hosts/darwin/kanata-tray.nix;
    spotifyd = builtins.import ./hosts/darwin/spotifyd.nix;
  };
}
