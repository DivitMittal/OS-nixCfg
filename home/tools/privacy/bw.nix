{
  pkgs,
  config,
  hostPlatform,
  ...
}: {
  # home.packages = [
  #   pkgs.bitwarden-cli
  # ];
  #
  # programs.rbw = {
  #   enable = false;
  #   package = pkgs.rbw;
  #
  #   settings = {
  #     email = config.hostSpec.email.personal;
  #     pinentry = (if hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry);
  #   };
  # };
}
