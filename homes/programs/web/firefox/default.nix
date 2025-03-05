{ config, pkgs, ... }:

let
  isDarwin = pkgs.stdenvNoCC.hostPlatform.isDarwin;
in
{
  home.file.tridactyl = {
    source = ./tridactyl;
    target = "${config.xdg.configHome}/tridactyl";
    recursive = true;
  };

  home.file.userChromeJS = {
    source = ./chrome/JS;
    target = "${config.home.homeDirectory}" + (if isDarwin then "/Library/Application Support/Firefox/Profiles/custom-default/chrome/JS" else "/.mozilla/firefox/custom-default/chrome/JS");
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

        # containers = {
        #   second = {
        #     color = "blue";
        #     icon = "tree";
        #     id = 1;
        #   };
        #   finance = {
        #     color = "green";
        #     icon = "dollar";
        #     id = 2;
        #   };
        # };
        # containersForce = true;

        search = {
          default = "Unduck";
          privateDefault = "Startpage";
          force = true;

          engines = {
            "Bing".metaData.hidden = true;
            # built-in engines only support specifying one additional alias
            "Google".metaData.alias = "@g";
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

            "Github" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                    { name = "type"; value = "repositories"; }
                  ];
                }
              ];
              definedAliases = [ "@gh" ];
            };

            "Startpage" = {
              urls = [
                {
                  template = "https://www.startpage.com/sp/search";
                  params = [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              definedAliases = [ "@sp" ];
            };

            "Unduck" = {
              urls = [
                {
                  template = "https://unduck.link/";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                  ];
                }
              ];
              definedAliases = [ "@ud"];
            };

            "Perplexity" = {
              urls = [
                {
                  template = "https://www.perplexity.ai";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                  ];
                }
              ];
              definedAliases = [ "@p" ];
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