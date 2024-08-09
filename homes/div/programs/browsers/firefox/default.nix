{ config, lib, pkgs, ... }:

{
  imports = [
    ./macOS_profile_hack.nix
  ];

  home.file.userChromeJS = {
    source = ./chrome/JS;
    target = "${config.home.homeDirectory}/Library/Application Support/Firefox/Profiles/custom-default/chrome/JS";
    recursive = true;
  };

  programs.firefox = {
    enable = true;
    package = null;

    nativeMessagingHosts = with pkgs;[ tridactyl-native ];

    profiles = {
      clean-profile = {
        id = 1;
        isDefault = false;
      };

      custom-default = {
        id = 0;
        isDefault = true;

        bookmarks = [];

        containers = {
          second = {
            color = "blue";
            icon = "tree";
            id = 1;
          };
          finance = {
            color = "green";
            icon = "dollar";
            id = 2;
          };
        };
        containersForce = true;

        search = {
          default = "Google";
          privateDefault = "Google";
          force = true;

          engines = {
            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # built-in engines only support specifying one additional alias
            "Wikipedia (en)".metaData.alias = "@w";
            "DuckDuckGo".metaData.alias = "@d";

            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                    { name = "channel"; value = "unstable"; }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "Youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [ { name = "search_query"; value = "{searchTerms}"; } ];
                }
              ];
              definedAliases = [ "@yt" ];
            };
          };
        };

        settings = import ./user_settings.nix;
        userContent = builtins.readFile ./chrome/CSS/userContent.css;
        userChrome = builtins.readFile ./chrome/CSS/userChrome.css;
      };
    };
  };
}