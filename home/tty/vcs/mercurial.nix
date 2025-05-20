{
  pkgs,
  config,
  ...
}: {
  programs.mercurial = {
    enable = false;
    package = pkgs.mercurial;

    userName = config.hostSpec.userFullName;
    userEmail = config.hostSpec.email.dev;

    ignores = builtins.import ./common/ignore.nix;
  };
}