{ username, hostname, config, lib, pkgs, ... }:

let
  inherit(lib) mkOption mkIf mkMerge;
  cfg = config.paths;
in
{
  imports = [
    ./shells.nix
    ./nixCfg.nix
  ];

  options = let inherit(lib) types; in {
    paths.homeDirectory = mkOption {
      type = types.str;
      default = if pkgs.stdenvNoCC.hostPlatform.isDarwin then "/Users/${username}" else "/home/${username}";
      description = "Path to your home directory";
    };

    paths.repo = mkOption {
      type = types.str;
      default = cfg.homeDirectory + "/OS-nixCfg";
      description = "Path to the repo that contains this nixOS/nix-darwin/nix-on-droid config along with other nix configs";
    };

    paths.secrets = mkOption {
      type = types.str;
      default = cfg.repo + "/secrets";
      description = "Path to repo secrets";
    };
  };

  config = {
    time.timeZone = "Asia/Calcutta";
    environment.extraOutputsToInstall = [ "info" ]; # "dev" "devdoc"

    documentation = {
      enable      = true;

      info.enable = true;
      man.enable  = true;
      doc.enable  = false;
    };

    programs.nix-index.enable = true;

    environment.systemPackages = builtins.attrValues {
      inherit(pkgs)
        bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent # GNU
        zip unzip curl vim git uutils-coreutils-noprefix
      ;
    };
  };
}