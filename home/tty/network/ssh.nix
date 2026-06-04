{
  pkgs,
  hostPlatform,
  config,
  ...
}: let
  sshDir = "${config.home.homeDirectory}/.ssh";
in {
  programs.ssh = {
    enable = true;
    package =
      if hostPlatform.isDarwin
      then null
      else pkgs.openssh;

    enableDefaultConfig = false;

    settings = {
      "10.254.200.59" = {
        User = "nix-on-droid";
        Port = 8022;
        IdentityFile = "${sshDir}/nix-on-droid/ssh_host_rsa_key";
      };
      "github.com" = {
        IdentityFile = "${sshDir}/github/id_ed25519";
      };
      "hf.co" = {
        IdentityFile = "${sshDir}/hf/hf";
      };
      "*" = {
        Compression = false;
        AddKeysToAgent = "yes";
        HashKnownHosts = false;
      };
    };
  };
}
