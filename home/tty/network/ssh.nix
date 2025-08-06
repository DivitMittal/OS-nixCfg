{
  pkgs,
  hostPlatform,
  config,
  ...
}: let
  sshDir = "${config.home.homeDirectory}/.ssh";
in {
  home.packages = [
    #pkgs.upterm
  ];

  programs.ssh = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then null
      else pkgs.openssh; # xcode-select

    compression = false;
    addKeysToAgent = "yes";
    hashKnownHosts = false;

    matchBlocks = {
      "10.254.200.59" = {
        user = "nix-on-droid";
        port = 8022;
        identityFile = "${sshDir}/nix-on-droid/ssh_host_rsa_key";
      };
      "github.com" = {
        identityFile = "${sshDir}/github/id_ed25519";
      };
      "hf.co" = {
        identityFile = "${sshDir}/hf/hf";
      };
    };
  };
}
