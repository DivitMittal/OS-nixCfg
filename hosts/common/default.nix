{ user, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  imports = [
    ./shells.nix
    ./nixCfg.nix
  ];

  options = let inherit(lib) mkOption types; in {
    paths.homeDirectory = mkOption {
      type = types.str;
      default = (if isDarwin then "/Users" else "/home") + "/${user.username}";
      description = "Path to your home directory";
    };
  };

  config = {
    time.timeZone = "Asia/Calcutta";
    environment.extraOutputsToInstall = [ "info" ]; # "doc" "devdoc"

    documentation = {
      enable      = true;

      info.enable = true;
      man.enable  = true;
      doc.enable  = false;
    };

    environment.systemPackages = builtins.attrValues {
      inherit(pkgs)
        bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent # GNU
        zip unzip curl vim uutils-coreutils-noprefix git
      ;
    };
  };
}