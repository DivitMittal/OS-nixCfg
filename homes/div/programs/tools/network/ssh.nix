{ config, pkgs, pkgs-darwin, ... }:
let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  programs.ssh = {
    enable = true;
    package = if isDarwin then null else pkgs.ssh; # homebrew

    includes = [ "~/.colima/ssh_config" ];
    compression = false;
    addKeysToAgent = "yes";

    extraConfig = ''
    Host github.com
      PreferredAuthentications publickey
      IdentityFile ~/.ssh/github/id_ed25519

    Host *
      User nix-on-droid
      Port 8022
      PubkeyAuthentication yes
      PreferredAuthentications publickey
      IdentityFile ~/.ssh/nix-on-droid/ssh_host_rsa_key
    '';
  };
}