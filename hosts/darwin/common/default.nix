{ config, lib, username, hostname, pkgs, inputs, ... }:

let
  inherit(lib) mkOption;
in
{
  imports = [
    ./shells.nix
    ./nixCfg.nix
  ];

  options = let inherit(lib) types; in {
    paths.repo = mkOption {
      type = types.str;
      default = "/Users/${username}/OS-nixCfg";
      description = "Path to the repo that contains this nix-darwin config along with other nix configs";
    };

    paths.currentDarwinCfg = mkOption {
      type = types.str;
      default = "${config.paths.repo}/hosts/darwin/${hostname}";
      description = "Path to darwin configs";
    };

    paths.secrets = mkOption {
      type = types.str;
      default = "${config.paths.repo}/secrets";
      description = "Path to repo secrets";
    };
  };

  config = {
    environment.systemPackages = builtins.attrValues {
      inherit(pkgs)
        bc diffutils findutils gnugrep inetutils gnused gawk which gzip gnutar wget gnupatch gnupg binutils gnumake groff indent # GNU
        zip unzip curl vim git uutils-coreutils-noprefix
      ;
    };

    time.timeZone = "Asia/Calcutta";

    networking = {
      knownNetworkServices = [ "Wi-Fi" ];

      # Cloudflare DNS
      dns = [
              "1.1.1.1"              "1.0.0.1"         # IPv4
        "2606:4700:4700::1111" "2606:4700:4700::1001"  # IPv6
      ];
    };

    # documentation
    documentation = {
      enable      = true;

      info.enable = true;
      man.enable  = true;

      doc.enable  = false;
    };
    environment.extraOutputsToInstall = [ "info" ]; # "dev" "devdoc"
    programs.man.enable  = true;
    programs.info.enable = true;


    system.activationScripts.postUserActivation.text = lib.mkAfter ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    system.stateVersion = 5;
  };
}