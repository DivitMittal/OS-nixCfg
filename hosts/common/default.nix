{ username, hostname, config, lib, pkgs, ... }:

let
  inherit(lib) mkOption mkIf mkMerge;
  cfg = config.paths;
in
{
  # imports = [ ] ++ lib.optional (hostname != "M1") {./shells.nix ./nixCfg.nix};
  imports = [
    ./shells.nix
    ./nixCfg.nix
  ];

  options = let inherit(lib) types; in {
    paths.homeDirectory = mkOption {
      type = types.path;
      default = if pkgs.stdenvNoCC.hostPlatform.isDarwin then /Users/${username} else /home/${username};
      description = "Path to your home directory";
    };

    paths.repo = mkOption {
      type = types.path;
      default = cfg.homeDirectory + /OS-nixCfg;
      description = "Path to the repo that contains this nixOS/nix-darwin/nix-on-droid config along with other nix configs";
    };

    paths.secrets = mkOption {
      type = types.str;
      default = cfg.repo + /secrets;
      description = "Path to repo secrets";
    };
  };

  # config = mkMerge [
  #
  #   {
  #     nix.package = pkgs.nixVersions.latest;
  #     time.timeZone = "Asia/Calcutta";
  #     environment.extraOutputsToInstall = [ "info" ]; # "dev" "devdoc"
  #   }
  #
  #   mkIf (hostname != "M1") {
  #     # documentation
  #     documentation = {
  #       enable      = true;
  #
  #       info.enable = true;
  #       man.enable  = true;
  #       doc.enable  = false;
  #     };
  #
  #     environment.systemPackages = builtins.attrValues {
  #       inherit(pkgs)
  #         bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent # GNU
  #         zip unzip curl vim git uutils-coreutils-noprefix
  #       ;
  #     };
  #   }
  # ];
  config = {
    nix.package = pkgs.nixVersions.latest;
    time.timeZone = "Asia/Calcutta";
    environment.extraOutputsToInstall = [ "info" ]; # "dev" "devdoc"

    documentation = {
      enable      = true;

      info.enable = true;
      man.enable  = true;
      doc.enable  = false;
    };

    environment.systemPackages = builtins.attrValues {
      inherit(pkgs)
        bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent # GNU
        zip unzip curl vim git uutils-coreutils-noprefix
      ;
    };
  };
}