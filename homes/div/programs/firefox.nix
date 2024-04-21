{ lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = null;

    nativeMessagingHosts = with pkgs;[ tridactyl-native ];

    profiles = {
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

        search = {
          default = "Google";
          privateDefault = "Google";
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{ template = "https://wiki.nixos.org/index.php?search={searchTerms}"; }];
              iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@nw" ];
            };

            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };

        userChrome = ''
          @charset "UTF-8";
          /* ---------------------------   STATUS PANEL ------------------------ */
          #statuspanel {
            display: none !important;
          }

          /* ---------------------------- TABBAR ---------------------------- */
          #titlebar {
            visibility: collapse;
          }

          #TabsToolbar {
            visibility: collapse;
          }

          /* ---------------------------- SIDEBAR --------------------------------- */
          #sidebar-box #sidebar-header {
            display:none !important;
          }

          /* -------------------------------- NAVBAR ----------------------------------- */
          /* Makes browser window first element sends the NAVBAR down */
          #browser {
            order: -1 !important;
          }

          #back-button, #forward-button, #reload-button, #stop-button, #home-button {
            display: none;
          }

          /* fxa - firefox account */
          #fxa-toolbar-menu-button {
            display: none;
          }

          /* Empty space before and after the url bar */
          #customizableui-special-spring1,
          #customizableui-special-spring2 {
            display: none;
          }

          #nav-bar, #navigator-toolbox {
            border-width: 0 !important;
            --toolbar-field-focus-border-color: #42414d;
          }

          /* -------------------------------- URLBAR ------------------------------------- */
          #urlbar-container {
            --urlbar-container-height: var(--tab-min-height) !important;
            margin-left: 0 !important;
            margin-right: 0 !important;
            padding-top: 0 !important;
            padding-bottom: 0 !important;
            font-family: "CaskaydiaCove Nerd Font";
            font-size: 11px;
          }

          #urlbar-background {
            border-width: 0 !important;
            border-radius: 0 !important;
          }

          #urlbar-input-container {
            border-width: 0 !important;
            margin-left: 1em !important;
          }

          #urlbar-input {
            margin-left: 0.4em !important;
            margin-right: 0.4em !important;
          }

          .urlbarView-row {
            padding-top: 0 !important;
            padding-bottom: 0 !important;
            line-height: var(--urlbar-height) !important;
          }

          .urlbarView-row-inner {
            padding-top: 0.3em !important;
            padding-bottom: 0.3em !important;
            height: var(--urlbar-height) !important;
          }

          .urlbarView-favicon {
            height: 1em !important;
            width: 1em !important;
            margin-bottom: 0.2em !important;
          }

          #urlbar-go-button, #star-button, #star-button-box, #pocket-button, #tracking-protection-icon-container {
            display: none !important;
          }

          #urlbar-input-container {
            order: 2;
          }

          #urlbar > .urlbarView {
            order: 1;
            border-bottom: 1px solid #666;
          }

          #urlbar-results {
            display: flex;
            flex-direction: column-reverse;
          }

          #urlbar {
            --urlbar-height: var(--tab-min-height) !important;
            --urlbar-toolbar-height: var(--tab-min-height) !important;
            --autocomplete-popup-highlight-background: transparent !important;
            top: unset !important;
            bottom: calc((var(--urlbar-toolbar-height) - var(--urlbar-height)) / 2) !important;
            box-shadow: none !important;
            display: flex !important;
            flex-direction: column !important;
          }
        '';

        # userContent = ''
        #
        # '';

        extraConfig = ''
          /****************************************************************************
          * Betterfox                                                                *
          * url: https://github.com/yokoffing/Betterfox                              *
          ****************************************************************************/

          /****************************************************************************
          * SECTION: FASTFOX                                                         *
          ****************************************************************************/
          user_pref("content.notify.interval", 100000);

          /* EXPERIMENTAL */
          user_pref("layout.css.grid-template-masonry-value.enabled", true);
          user_pref("dom.enable_web_task_scheduling", true);
          user_pref("layout.css.has-selector.enabled", true);
          user_pref("dom.security.sanitizer.enabled", true);

          /* GFX **/
          user_pref("gfx.canvas.accelerated.cache-items", 4096);
          user_pref("gfx.canvas.accelerated.cache-size", 512);
          user_pref("gfx.content.skia-font-cache-size", 20);

          /* BROWSER CACHE **/
          user_pref("browser.cache.disk.enable", false);

          /* DISK CACHE */
          user_pref("browser.cache.jsbc_compression_level", 3);

          /* MEDIA CACHE */
          user_pref("media.memory_cache_max_size", 65536);
          user_pref("media.cache_readahead_limit", 7200);
          user_pref("media.cache_resume_threshold", 3600);

          /* IMAGE CACHE */
          user_pref("image.mem.decode_bytes_at_a_time", 32768);

          /* NETWORK */
          user_pref("network.buffer.cache.size", 262144);
          user_pref("network.buffer.cache.count", 128);

          user_pref("network.http.max-connections", 1800);
          user_pref("network.http.max-persistent-connections-per-server", 10);
          user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
          user_pref("network.http.pacing.requests.enabled", false);

          user_pref("network.websocket.max-connections", 400);

          user_pref("network.dnsCacheEntries", 10000);
          user_pref("network.dnsCacheExpiration", 86400);
          user_pref("network.dns.max_high_priority_threads", 8);
          user_pref("network.dns.disablePrefetch", true);

          user_pref("network.ssl_tokens_cache_capacity", 20480);

          /* SPECULATIVE CONNECTIONS */
          user_pref("network.early-hints.enabled", true);
          user_pref("network.early-hints.preconnect.enabled", true);
          user_pref("network.predictor.enabled", false);
          user_pref("network.predictor.enable-prefetch", false);
          user_pref("network.prefetch-next", false);

          /****************************************************************************
          * SECTION: SECUREFOX                                                       *
          ****************************************************************************/
          /* TRACKING PROTECTION */
          user_pref("browser.contentblocking.category", "strict");
          user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
          user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
          user_pref("network.cookie.sameSite.noneRequiresSecure", true);
          user_pref("browser.uitour.enabled", false);
          user_pref("privacy.globalprivacycontrol.enabled", true);
          user_pref("privacy.globalprivacycontrol.functionality.enabled", true);

          /* OCSP & CERTS / HPKP */
          user_pref("security.OCSP.enabled", 0);
          user_pref("security.remote_settings.crlite_filters.enabled", true);
          user_pref("security.pki.crlite_mode", 2);

          /* SSL / TLS */
          user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
          user_pref("browser.xul.error_pages.expert_bad_cert", true);
          user_pref("security.tls.enable_0rtt_data", false);

          /* DISK AVOIDANCE */
          user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
          user_pref("browser.sessionstore.interval", 60000);

          /* SHUTDOWN & SANITIZING */
          user_pref("privacy.history.custom", true);

          /* URL BAR */
          user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
          user_pref("browser.urlbar.update2.engineAliasRefresh", true);
          user_pref("browser.search.suggest.enabled", false);
          user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
          user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
          user_pref("browser.formfill.enable", false);
          user_pref("security.insecure_connection_text.enabled", true);
          user_pref("security.insecure_connection_text.pbmode.enabled", true);
          user_pref("network.IDN_show_punycode", true);

          /* HTTPS-FIRST POLICY */
          user_pref("dom.security.https_first", false);

          /* PASSWORDS AND AUTOFILL */
          user_pref("signon.rememberSignons", false);
          user_pref("editor.truncate_user_pastes", false);

          /* ADDRESS + CREDIT CARD MANAGER */
          user_pref("extensions.formautofill.addresses.enabled", false);
          user_pref("extensions.formautofill.creditCards.enabled", false);

          /* MIXED CONTENT + CROSS-SITE */
          user_pref("network.auth.subresource-http-auth-allow", 1);
          user_pref("security.mixed_content.block_display_content", true);
          user_pref("security.mixed_content.upgrade_display_content", true);
          user_pref("pdfjs.enableScripting", false);
          user_pref("extensions.postDownloadThirdPartyPrompt", false);
          user_pref("permissions.delegation.enabled", false);

          /* HEADERS REFERERS */
          user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

          /* CONTAINERS */
          user_pref("privacy.userContext.ui.enabled", true);

          /* WEBRTC */
          user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
          user_pref("media.peerconnection.ice.default_address_only", true);

          /* SAFE BROWSING */
          user_pref("browser.safebrowsing.downloads.remote.enabled", true);

          /* MOZILLA */
          user_pref("permissions.default.desktop-notification", 2);
          user_pref("permissions.default.geo", 2);
          user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
          user_pref("permissions.manager.defaultsUrl", "");
          user_pref("webchannel.allowObject.urlWhitelist", "");

          /* TELEMETRY */
          user_pref("datareporting.policy.dataSubmissionEnabled", false);
          user_pref("datareporting.healthreport.uploadEnabled", false);
          user_pref("toolkit.telemetry.unified", false);
          user_pref("toolkit.telemetry.enabled", false);
          user_pref("toolkit.telemetry.server", "data:,");
          user_pref("toolkit.telemetry.archive.enabled", false);
          user_pref("toolkit.telemetry.newProfilePing.enabled", false);
          user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
          user_pref("toolkit.telemetry.updatePing.enabled", false);
          user_pref("toolkit.telemetry.bhrPing.enabled", false);
          user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
          user_pref("toolkit.telemetry.coverage.opt-out", true);
          user_pref("toolkit.coverage.opt-out", true);
          user_pref("toolkit.coverage.endpoint.base", "");
          user_pref("browser.ping-centre.telemetry", false);
          user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
          user_pref("browser.newtabpage.activity-stream.telemetry", false);

          /* EXPERIMENTS */
          user_pref("app.shield.optoutstudies.enabled", false);
          user_pref("app.normandy.enabled", false);
          user_pref("app.normandy.api_url", "");

          /* CRASH REPORTS */
          user_pref("breakpad.reportURL", "");
          user_pref("browser.tabs.crashReporting.sendReport", false);
          user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

          /* DETECTION */
          // user_pref("captivedetect.canonicalURL", "");
          user_pref("network.captive-portal-service.enabled", true);
          user_pref("network.connectivity-service.enabled", true);

          /****************************************************************************
          * SECTION: PESKYFOX                                                        *
          ****************************************************************************/
          /* MOZILLA UI */
          user_pref("layout.css.prefers-color-scheme.content-override", 2);
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("browser.compactmode.show", true);
          user_pref("browser.privatebrowsing.vpnpromourl", "");
          user_pref("extensions.getAddons.showPane", false);
          user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
          user_pref("browser.discovery.enabled", false);
          user_pref("browser.shell.checkDefaultBrowser", false);
          user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
          user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
          user_pref("browser.preferences.moreFromMozilla", false);
          user_pref("browser.tabs.tabmanager.enabled", false);
          user_pref("browser.aboutConfig.showWarning", false);
          user_pref("browser.aboutwelcome.enabled", false);
          user_pref("browser.display.focus_ring_on_anything", true);
          user_pref("browser.display.focus_ring_style", 0);
          user_pref("browser.display.focus_ring_width", 0);
          user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS
          user_pref("browser.privatebrowsing.enable-new-indicator", false);
          user_pref("cookiebanners.service.mode", 2);
          user_pref("cookiebanners.service.mode.privateBrowsing", 2);
          user_pref("browser.translations.enable", true);

          /* FULLSCREEN */
          user_pref("full-screen-api.transition-duration.enter", "0 0");
          user_pref("full-screen-api.transition-duration.leave", "0 0");
          user_pref("full-screen-api.warning.delay", -1);
          user_pref("full-screen-api.warning.timeout", 0);

          /** URL BAR ***/
          user_pref("browser.urlbar.suggest.calculator", true);
          user_pref("browser.urlbar.unitConversion.enabled", true);

          /* NEW TAB PAGE */
          user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
          user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

          /* POCKET */
          user_pref("extensions.pocket.enabled", false);

          /* DOWNLOADS */
          user_pref("browser.download.useDownloadDir", false);
          user_pref("browser.download.always_ask_before_handling_new_types", true);
          user_pref("browser.download.alwaysOpenPanel", false);
          user_pref("browser.download.manager.addToRecentDocs", false);

          /** PDF ***/
          user_pref("browser.download.open_pdf_attachments_inline", true);

          /* TAB BEHAVIOR */
          user_pref("browser.bookmarks.openInTabClosesMenu", false);
          user_pref("browser.menu.showViewImageInfo", true);
          user_pref("findbar.highlightAll", true);

          /****************************************************************************
          * END: BETTERFOX                                                           *
          ****************************************************************************/
        '';
      };
    };
  };
}