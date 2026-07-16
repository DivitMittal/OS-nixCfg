{
  config,
  inputs,
  self,
  hostPlatform,
  base16Scheme,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs self hostPlatform base16Scheme;
    };

    users.${config.hostSpec.username} = {
      fonts.fontconfig.enable = false;

      imports = [
        (self + "/common/all/hostSpec.nix")
        (self + "/common/home/hm.nix")
        (self + "/common/home/helpers.nix")
        self.outputs.homeManagerModules.default

        (self + "/home/tty/alt.nix")
        (self + "/home/tty/atuin.nix")
        (self + "/home/tty/btop.nix")
        (self + "/home/tty/help.nix")
        (self + "/home/tty/viewers.nix")
        (self + "/home/tty/editors/editorconfig.nix")
        (self + "/home/tty/editors/misc.nix")
        (self + "/home/tty/editors/vim.nix")
        (inputs.import-tree (self + "/home/tty/find"))
        (self + "/home/tty/network/misc.nix")
        (inputs.import-tree (self + "/home/tty/pagers"))
        (inputs.import-tree (self + "/home/tty/shells"))
        (inputs.import-tree (self + "/home/tty/vcs"))
        (inputs.import-tree (self + "/home/dev"))
      ];
    };
  };
}
