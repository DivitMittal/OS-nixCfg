{ config, pkgs, ... }:

{
  # impure
  home.file.aerc = {
    enable = false;
    source = /. + "${config.paths.secrets}/email/aerc/accounts.conf";
    target = "${config.xdg.configHome}/aerc/accounts.conf";
  };

  programs.aerc = {
    enable = true;
    package = pkgs.aerc;

    extraBinds = builtins.readFile ./binds.conf;
    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
        default-menu-cmd     = "fzf --multi";
      };

      ui = {
        index-columns         = "name<17,flags>4,subject<*,date<20";
        sidebar-width         = 30;
        mouse-enabled         = true;
        styleset-name         = "pink";
        fuzzy-complete        = true;
        icon-unencrypted      = "";
        icon-encrypted        = "✔";
        icon-signed           = "✔";
        icon-signed-encrypted = "✔";
        icon-unknown          = "✘";
        icon-invalid          = "⚠";
      };

      filters = {
        "text/plain"              = "colorize";
        "text/calendar"           = "calendar";
        "message/delivery-status" = "colorize";
        "message/rfc822"          = "colorize";
        "text/html"               = "html | colorize";
        # "text/html"               = "${config.home.homeDirectory}/Downloads/carbonyl/carbonyl";
        "application/x-sh"        = "bat -fP -l sh";
      };

      openers = {
        "x-scheme-handler/irc" = "weechat";
        "text/plain"           = "${config.home.sessionVariables.VISUAL}";
      };
    };
  };
}