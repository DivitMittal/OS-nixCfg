{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.OS-nixCfg-secrets.homeManagerConfigurations.aercAccounts
  ];

  programs.aerc = {
    enable = true;
    package = pkgs.aerc;

    extraBinds = import ./binds.nix;
    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
        default-menu-cmd = "${pkgs.fzf}/bin/fzf --multi";
      };

      ui = {
        styleset-name = "nord";
        index-columns = "name<17,flags>4,subject<*,date<20";
        sidebar-width = 30;
        mouse-enabled = true;
        fuzzy-complete = true;
        icon-unencrypted = "";
        icon-encrypted = "✔";
        icon-signed = "✔";
        icon-signed-encrypted = "✔";
        icon-unknown = "✘";
        icon-invalid = "⚠";
      };

      filters = {
        "text/plain" = "colorize";
        "text/calendar" = "calendar";
        "message/delivery-status" = "colorize";
        "message/rfc822" = "colorize";
        "text/html" = "!${pkgs.lynx}/bin/lynx -stdin";
        "application/x-sh" = "bat -fP -l sh";
      };

      openers = {
        "x-scheme-handler/irc" = "${pkgs.weechat}/bin/weechat";
        "text/plain" = "${config.home.sessionVariables.EDITOR}";
      };
    };
  };
}
