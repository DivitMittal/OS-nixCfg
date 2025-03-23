{ config, pkgs, hostPlatform, ... }:

let
  profiles = {
    clean-profile = {
      id = 0;
      isDefault = false;
    };

    custom-default = {
      id = 1;
      isDefault = true;

      bookmarks = [];

      # containers = {
      #   second = {
      #     color = "blue";
      #     icon = "tree";
      #     id = 1;
      #   };
      #   finance = {;
      #     color = "green";
      #     icon = "dollar";
      #     id = 2;
      #   };
      # };
      # containersForce = true;

      search = {
        default = "Unduck";
        privateDefault = "Unduck";
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
                template = "https://unduck.link";
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

      settings = builtins.import ./user_settings.nix;
      userContent = builtins.readFile ./chrome/CSS/userContent.css;
      userChrome = builtins.readFile ./chrome/CSS/userChrome.css;
    };
  };
in
{
  xdg.configFile."tridactyl" = {
    source = ./tridactyl;
    recursive = true;
  };

  ## Firefox
  programs.firefox = {
    enable = true;
    package = null; # homebrew

    nativeMessagingHosts = with pkgs;[ tridactyl-native ];

    inherit profiles;
  };

  home.file.firefoxUserChromeJS = {
    source = ./chrome/JS;
    target = "${config.programs.firefox.configPath}" + (if hostPlatform.isDarwin then "/Profiles" else "") + "/custom-default/chrome/JS";
    recursive = true;
  };

  ## Mercury (firefox-fork)
  # programs.librewolf = {
  #   enable = true;
  #   package = null; # binary
  #
  #   name = "mercury";
  #   configPath = if hostPlatform.isDarwin then "Library/Application Support/mercury" else ".mozilla";
  #
  #   nativeMessagingHosts = with pkgs;[ tridactyl-native ];
  #
  #   inherit profiles;
  # };
  # home.file.MercuryUserChromeJS = {
  #   source = ./chrome/JS;
  #   target = "${config.programs.librewolf.configPath}" + (if hostPlatform.isDarwin then "/Profiles" else "") + "/custom-default/chrome/JS";
  #   recursive = true;
  # };
}