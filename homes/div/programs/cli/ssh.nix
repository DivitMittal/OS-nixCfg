{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mosh
  ];

  programs.ssh = {
    enable = true;
    package = null;

    compression = false;
    extraConfig = ''
      Include ${config.home.homeDirectory}/.colima/ssh_config

      Host github.com
        AddKeysToAgent yes
        PreferredAuthentications publickey
        IdentityFile ${config.home.homeDirectory}/.ssh/github/id_ed25519

      Host [192.0.0.4]:8022
        AddKeysToAgent yes
        PreferredAuthentications publickey
        IdentityFile ${config.home.homeDirectory}/.ssh/nix-on-droid/ssh_rsa
    '';
  };
}