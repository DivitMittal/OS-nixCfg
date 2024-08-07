{ lib, pkgs, ... }:

{
  # imports = [
  #   ./macOS_profile_hack.nix
  # ];

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

        userContent = ''
          @charset "UTF-8";

          /* makes sures that tridactyl's new-tab is a blank page */
          @-moz-document regexp("moz-extension://.*/static/newtab.html") {
            body {
              display: none !important;
            }
          }
        '';

        userChrome = ''
          @charset "UTF-8";

          /* --------------------------- STATUS PANEL ------------------------ */
          /* hide statuspanel */
          #statuspanel {
            display: none !important;
          }

          /* ------------------------------ TABBAR ---------------------------- */
          /* hide tabtoolbar */
          #TabsToolbar {
            visibility: collapse;
          }

          /* ----------------------------- SIDEBAR ----------------------------- */
          /* hide sidebar header  */
          #sidebar-box #sidebar-header {
            visibility:collapse !important;
          }

          /* Sideberry */
          /* normal website page right margin for collapsing sidebar */
          #main-window #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929-sidebar-action"]:not([hidden])~#appcontent {
            margin-right: 20px;
          }

          /* in-fullscreen right-margin for collapsing sidebar */
          #main-window[inFullscreen][inDOMFullscreen] #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929-sidebar-action"]:not([hidden])~#appcontent {
            margin-right: 0 !important;
          }

          /* ------------------------------ NAVBAR ----------------------------- */
          /* Makes browser window first element sends the NAVBAR down */
          /* #browser { */
          /*    order: -1 !important; */
          /*  } */

          /* hides unwanted buttons & items from the navbar */
          #back-button, #forward-button, #reload-button, #stop-button, #home-button, #fxa-toolbar-menu-button {
            display: none;
          }

          /* Empty space before and after the url bar */
          #customizableui-special-spring1, #customizableui-special-spring2 {
            display: none;
          }

          #nav-bar {
            --navbar-margin: -20px;
            --toolbar-field-focus-border-color: #14C800;

            border-width: 1px !important;
            margin-top: var(--navbar-margin);
            margin-bottom: 0;
            transition: all 0.1s ease !important;
          }

          #navigator-toolbox:focus-within > #nav-bar,
          #navigator-toolbox:hover > #nav-bar {
            margin-top: 0;
            margin-bottom: var(--navbar-margin);
            z-index: 5;
          }

          /* hides navbar for sure when in fullscreen */
          #nav-bar[inFullscreen] {
            display: none !important;
          }

          /* Disable auto-hiding when in 'customize' mode */
          :root[customizing] #navigator-toolbox{
            position: relative !important;
            margin-top: 0px;
          }

          /* ---------------------------- URLBAR ------------------------------ */
          #urlbar-go-button, #star-button, #star-button-box, #pocket-button, #tracking-protection-icon-container {
            display: none !important;
          }

          #urlbar-container {
            margin-left: 0 !important;
            margin-right: 0 !important;
            padding-top: 0 !important;
            padding-bottom: 0 !important;
            font-family: "CaskaydiaCove Nerd Font";
            font-size: 15px;
          }

          #urlbar {
            top: 0px !important;
            bottom: unset !important;
            box-shadow: none !important;
            display: flex !important;
            flex-direction: column !important;
          }

          #urlbar-background {
            border-width: 0 !important;
            border-radius: 0 !important;
          }
        '';
      };
    };
  };
}