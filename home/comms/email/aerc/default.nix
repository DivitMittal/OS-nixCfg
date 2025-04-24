{
  config,
  pkgs-master,
  ...
}: {
  programs.aerc = {
    enable = true;
    package = pkgs-master.aerc;

    extraBinds = builtins.import ./binds.nix;
    extraConfig = {
      general = {
        unsafe-accounts-conf = true;
        default-menu-cmd = "fzf --multi";
      };

      ui = {
        index-columns = "name<17,flags>4,subject<*,date<20";
        sidebar-width = 30;
        mouse-enabled = true;
        styleset-name = "pink";
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
        "text/html" = "html | colorize";
        "application/x-sh" = "bat -fP -l sh";
      };

      openers = {
        "x-scheme-handler/irc" = "weechat";
        "text/plain" = "${config.home.sessionVariables.VISUAL}";
      };
    };
  };
}
