{
  "content.notify.interval" = 100000; # in microseconds
  "layout.css.grid-template-masonry-value.enabled" = true;
  "layout.css.has-selector.enabled" = true;
  "dom.enable_web_task_scheduling" = true;

  # GFX
  "gfx.canvas.accelerated.cache-items" = 4096;
  "gfx.canvas.accelerated.cache-size" = 512;
  "gfx.content.skia-font-cache-size" = 20;

  # BROWSER CACHE
  "browser.cache.disk.enable" = false;
  "browser.cache.memory.enable" = true;

  # DISK CACHE
  "browser.cache.jsbc_compression_level" = 3;

  # MEDIA CACHE
  "media.memory_cache_max_size" = 65536;
  "media.cache_readahead_limit" = 7200;
  "media.cache_resume_threshold" = 3600;

  # IMAGE CACHE
  "image.mem.decode_bytes_at_a_time" = 32768;

  # NETWORK
  "network.buffer.cache.size" = 262144;
  "network.buffer.cache.count" = 128;

  "network.http.max-connections" = 1800;
  "network.http.max-persistent-connections-per-server" = 10;
  "network.http.max-urgent-start-excessive-connections-per-host" = 5;
  "network.http.pacing.requests.enabled" = false;

  "network.websocket.max-connections" = 400;

  "network.dnsCacheEntries" = 10000;
  "network.dnsCacheExpiration" = 86400;
  "network.dns.max_high_priority_threads" = 8;
  "network.dns.disablePrefetch" = false;

  "network.ssl_tokens_cache_capacity" = 20480;

  # SPECULATIVE CONNECTIONS
  "network.early-hints.enabled" = true;
  "network.early-hints.preconnect.enabled" = true;
  "network.predictor.enabled" = true;
  "network.predictor.enable-prefetch" = true;
  "network.prefetch-next" = true;

  #***************************************************************************
  #* SECTION: SECUREFOX                                                      *
  #***************************************************************************
  # TRACKING PROTECTION */
  #"browser.contentblocking.category" = "strict";
  "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
  "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
  "network.cookie.sameSite.noneRequiresSecure" = true;
  "privacy.globalprivacycontrol.enabled" = true;
  "privacy.globalprivacycontrol.functionality.enabled" = true;

  # OCSP & CERTS / HPKP */
  "security.OCSP.enabled" = 0;
  "security.remote_settings.crlite_filters.enabled" = true;
  "security.pki.crlite_mode" = 2;

  # SSL/TLS
  "security.ssl.treat_unsafe_negotiation_as_broken" = true;
  "browser.xul.error_pages.expert_bad_cert" = true;
  "security.tls.enable_0rtt_data" = false;

  # DISK AVOIDANCE
  "browser.privatebrowsing.forceMediaMemoryCache" = true;
  "browser.sessionstore.interval" = 60000;

  # SHUTDOWN & SANITIZING
  "privacy.history.custom" = true;

  # URL BAR
  "browser.formfill.enable" = false;
  "security.insecure_connection_text.enabled" = true;
  "security.insecure_connection_text.pbmode.enabled" = true;
  "network.IDN_show_punycode" = true;

  # HTTPS-FIRST POLICY
  "dom.security.https_first" = false;
  "dom.security.sanitizer.enabled" = true;

  # PASSWORDS AND AUTOFILL
  "signon.rememberSignons" = false;
  "editor.truncate_user_pastes" = false;

  # ADDRESS + CREDIT CARD MANAGER
  "extensions.formautofill.addresses.enabled" = false;
  "extensions.formautofill.creditCards.enabled" = false;

  # MIXED CONTENT + CROSS-SITE
  "network.auth.subresource-http-auth-allow" = 1;
  "security.mixed_content.block_display_content" = true;
  "security.mixed_content.upgrade_display_content" = true;
  "pdfjs.enableScripting" = false;
  "extensions.postDownloadThirdPartyPrompt" = false;
  "permissions.delegation.enabled" = false;

  # HEADERS REFERERS
  "network.http.referer.XOriginTrimmingPolicy" = 2;

  # CONTAINERS
  "privacy.userContext.ui.enabled" = true;

  # WEBRTC
  "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
  "media.peerconnection.ice.default_address_only" = true;

  # SAFE BROWSING
  "browser.safebrowsing.downloads.remote.enabled" = true;

  # MOZILLA
  "permissions.default.desktop-notification" = 2;
  "permissions.default.geo" = 2;
  "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
  "permissions.manager.defaultsUrl" = "";
  "webchannel.allowObject.urlWhitelist" = "";

  # TELEMETRY
  "datareporting.policy.dataSubmissionEnabled" = false;
  "datareporting.healthreport.uploadEnabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.server" = "data:,";
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.coverage.opt-out" = true;
  "toolkit.coverage.opt-out" = true;
  "toolkit.coverage.endpoint.base" = "";
  "browser.ping-centre.telemetry" = false;
  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;

  # EXPERIMENTS */
  "app.shield.optoutstudies.enabled" = false;
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";

  # CRASH REPORTS */
  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = false;
  "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

  # DETECTION */
  #"captivedetect.canonicalURL" = "";
  "network.captive-portal-service.enabled" = true;
  "network.connectivity-service.enabled" = true;

  #***************************************************************************
  # SECTION: PESKYFOX                                                        *
  #***************************************************************************
  # MOZILLA UI
  "browser.uitour.enabled" = false;
  "browser.uidensity" = 1;
  "browser.compactmode.show" = true;
  "layout.css.prefers-color-scheme.content-override" = 2;
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  "browser.privatebrowsing.vpnpromourl" = "";
  "extensions.getAddons.showPane" = false;
  "extensions.htmlaboutaddons.recommendations.enabled" = false;
  "browser.discovery.enabled" = false;
  "browser.preferences.moreFromMozilla" = false;
  "browser.tabs.tabmanager.enabled" = false;
  "browser.aboutConfig.showWarning" = false;
  "browser.aboutwelcome.enabled" = false;
  "browser.display.focus_ring_on_anything" = true;
  "browser.display.focus_ring_style" = 0;
  "browser.display.focus_ring_width" = 0;
  "browser.privateWindowSeparation.enabled" = false; # WINDOWS
  "browser.privatebrowsing.enable-new-indicator" = false;
  "cookiebanners.service.mode" = 2;
  "cookiebanners.service.mode.privateBrowsing" = 2;
  "browser.translations.enable" = true;

  # Bookmarks bar
  "browser.toolbars.bookmarks.visibility" =	"never";

  # Titlebar
  "browser.tabs.inTitlebar" =	1;

  # pip
  "media.videocontrols.picture-in-picture.video-toggle.has-used" =	true;
  "media.videocontrols.picture-in-picture.video-toggle.position" =	"top";

  # Default Check
  "browser.shell.checkDefaultBrowser" = false;
  "browser.shell.defaultBrowserCheckCount" =	1;
  "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" =	true;

  # FULLSCREEN
  "full-screen-api.transition-duration.enter" = "0 0";
  "full-screen-api.transition-duration.leave" = "0 0";
  "full-screen-api.warning.delay" = -1;
  "full-screen-api.transition.timeout" = 0;
  "full-screen-api.warning.timeout" = 0;

  # URL BAR
  "browser.urlbar.suggest.calculator" = true;
  "browser.urlbar.unitConversion.enabled" = true;
  "browser.urlbar.update1" = false; # smaller search engine suggestion prompt
  "browser.search.separatePrivateDefault.ui.enabled" = true;
  "browser.urlbar.update2.engineAliasRefresh" = true;
  # suggestions
  "browser.search.suggest.enabled" = true;
  "browser.search.suggest.enabled.private" = true;
  "browser.urlbar.showSearchSuggestionsFirst" = false;
  "browser.urlbar.suggest.quicksuggest.sponsored" = true;
  "browser.urlbar.suggest.quicksuggest.nonsponsored" = true;
  # shortcuts
  "browser.urlbar.shortcuts.bookmarks" = false;
  "browser.urlbar.shortcuts.history" = false;
  "browser.urlbar.shortcuts.quickactions" = false;
  "browser.urlbar.shortcuts.tabs" = false;

  # NEW TAB PAGE
  "browser.display.background_color.dark" = "#000000";
  "browser.newtabpage.activity-stream.feeds.topsites" = false;
  "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

  # Pocket
  "extensions.pocket.enabled" = false;

  # Downloads
  "browser.download.useDownloadDir" = false;
  "browser.download.always_ask_before_handling_new_types" = true;
  "browser.download.alwaysOpenPanel" = false;
  "browser.download.manager.addToRecentDocs" = false;

  # PDF
  "browser.download.open_pdf_attachments_inline" = true;

  # TAB BEHAVIOR
  "browser.bookmarks.openInTabClosesMenu" = false;
  "browser.menu.showViewImageInfo" = true;
  "findbar.highlightAll" = true;

  # Scrolling
  "widget.non-native-theme.scrollbar.style" = 3;
  "apz.overscroll.enabled" = false;
  "general.smoothScroll.msdPhysics.enabled" = true;
  "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 250;
  "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 400;
  "general.smoothScroll.msdPhysics.regularSpringConstant" = 400;
  "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 120;
  "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" =  0.4;
  "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 5000;
  "mousewheel.min_line_scroll_amount" = 22;
  "toolkit.scrollbox.horizontalScrollDistance" = 4;
  "toolkit.scrollbox.verticalScrollDistance" = 5;
  "apz.frame_delay.enabled" = false;

  # Enable browser chrome devtools */
  "devtools.chrome.enabled" =	true; # enable browser-toolbox
  "devtools.debugger.remote-enabled" =	true; # enable remote debugger for browser-toolbox
}