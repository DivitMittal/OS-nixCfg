{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.system.daemonBuster;

  # ── Service database ──────────────────────────────────────────────────────────
  # Keys per group: user (gui/501), system, user205 (user/205 = _locationd, pre-login).
  # A missing key means no services for that domain in that group.
  groups = {
    accessibility.user = [
      "com.apple.accessibility.MotionTrackingAgent" # Head/body motion pointer and accessibility control features.
      "com.apple.accessibility.axassetsd" # Downloads and manages accessibility support assets.
      "com.apple.universalaccessd" # Core Accessibility/Universal Access daemon; can affect assistive tech and UI automation.
      "com.apple.voicebankingd" # Personal Voice / voice banking support for accessibility speech features.
    ];

    ads.user = [
      "com.apple.ap.adprivacyd" # Apple advertising privacy attribution bookkeeping.
      "com.apple.ap.promotedcontentd" # App Store/News promoted content and ad delivery support.
    ];

    advertising.system = ["com.apple.adid"]; # System advertising identifier service.

    assetCache.system = [
      "com.apple.AssetCache.builtin" # Content Caching server (shares downloads with local devices).
      "com.apple.AssetCacheTetheratorService" # Tethered caching over USB for iOS devices.
    ];

    analytics = {
      user = [
        "com.apple.geoanalyticsd" # Location/geography analytics collection.
        "com.apple.inputanalyticsd" # Keyboard/input analytics collection.
        "com.apple.analyticsagent" # Per-user analytics event collection.
        "com.apple.metrickitd" # MetricKit app performance/diagnostic metrics.
        "com.apple.dprivacyd" # Differential privacy collection.
        "com.apple.webprivacyd" # Safari/WebKit privacy telemetry support.
        "com.apple.feedbackd" # Feedback Assistant background submission agent.
      ];
      system = [
        "com.apple.analyticsd" # System analytics event collection.
        "com.apple.audioanalyticsd" # Audio subsystem analytics collection.
        "com.apple.ecosystemanalyticsd" # Cross-device ecosystem analytics.
        "com.apple.wifianalyticsd" # Wi-Fi diagnostics/analytics collection.
        "com.apple.osanalytics.osanalyticshelper" # Crash/panic analytics helper.
        "com.apple.perfpowermetricd" # Performance and power metric collection.
        "com.apple.dprivacyd" # System differential privacy collection.
      ];
    };

    appleIntelligence = {
      user = [
        "com.apple.assistant_service" # Siri/Assistant request handling.
        "com.apple.assistantd" # Siri assistant daemon.
        "com.apple.assistant_cdmd" # Siri command/domain model support.
        "com.apple.callintelligenced" # Call transcription/screening intelligence features.
        "com.apple.Siri.agent" # Siri user agent and menu/UI integration.
        "com.apple.siriinferenced" # Siri on-device inference.
        "com.apple.sirittsd" # Siri text-to-speech service.
        "com.apple.siriknowledged" # Siri knowledge/context store.
        "com.apple.SiriTTSTrainingAgent" # Siri voice/TTS training data agent.
        "com.apple.ContextStoreAgent" # User context store for suggestions/intelligence.
        "com.apple.duetexpertd" # CoreDuet predictions and proactive suggestions.
        "com.apple.generativeexperiencesd" # Apple Intelligence generative feature runtime.
        "com.apple.intelligenceflowd" # Apple Intelligence task flow orchestration.
        "com.apple.intelligencecontextd" # Apple Intelligence context collection.
        "com.apple.intelligenceplatformd" # Apple Intelligence platform daemon.
        "com.apple.knowledge-agent" # Knowledge graph extraction for Siri/intelligence.
        "com.apple.knowledgeconstructiond" # Builds local knowledge used by suggestions/intelligence.
        "com.apple.naturallanguaged" # Natural language parsing; can affect dictation and text features.
        "com.apple.parsec-fbf" # Siri Suggestions/Search feedback.
        "com.apple.parsecd" # Siri Suggestions, Spotlight suggestions, and remote search suggestions.
        "com.apple.routined" # Significant-locations/routine learning used by suggestions and Maps.
        "com.apple.suggestd" # System-wide Siri Suggestions.
        "com.apple.textunderstandingd" # Text understanding/classification for intelligence features.
        "com.apple.synapse.contentlinkingd" # Content linking/indexing for intelligence features.
        "com.apple.privatecloudcomputed" # Private Cloud Compute client support.
        "com.apple.intelligencetasksd" # Apple Intelligence background task execution.
        "com.apple.intelligentroutingd" # Routes requests between local/cloud intelligence paths.
        "com.apple.proactived" # Proactive suggestions engine.
        "com.apple.proactiveeventtrackerd" # Tracks events used by proactive suggestions.
        "com.apple.replayd" # Screen/interaction replay capture support for intelligence/debug features.
        "com.apple.corespeechd" # Speech recognition runtime; used by Siri, Dictation, and third-party voice features.
        "com.apple.followupd" # Follow-up reminders and actionable items surfaced by on-device intelligence.
        "com.apple.spotlightknowledged" # Semantic knowledge graph powering Apple Intelligence and enhanced Spotlight suggestions; lives in CoreSpotlight.framework but its primary role is AI inference — basic file search (mds) works without it.
        "com.apple.spotlightknowledged.importer" # Imports content into the Apple Intelligence knowledge graph.
        "com.apple.spotlightknowledged.updater" # Incrementally updates the Apple Intelligence knowledge graph.
        "com.apple.siriactionsd" # Siri Actions integration for third-party shortcuts.
        "com.apple.milod" # On-device ML inference host.
      ];
      system = [
        "com.apple.coreduetd" # Cross-app activity database used by suggestions and handoff-like features.
        "com.apple.modelmanagerd" # Manages on-device ML/intelligence models.
        "com.apple.contextstored" # System context store for intelligence and suggestions.
        "com.apple.modelcatalogd" # Catalogs/downloads ML model assets.
        "com.apple.multiversed" # Apple Intelligence multi-model coordination.
        "com.apple.ospredictiond" # OS prediction engine for proactive behavior.
        "com.apple.centaurid" # Apple Intelligence model/service coordinator.
      ];
    };

    applePay.user = [
      "com.apple.financed" # Apple Pay/Wallet finance account support.
      "com.apple.passd" # Wallet passes, Apple Pay cards, and pass sync.
    ];

    biome = {
      user = [
        "com.apple.BiomeAgent" # Biome user activity/event database agent.
        "com.apple.biomesyncd" # Syncs Biome activity data across devices.
      ];
      system = ["com.apple.biomed"]; # System Biome activity/event database daemon.
    };

    books.user = [
      "com.apple.bookassetd" # Apple Books downloads/assets.
      "com.apple.bookdatastored" # Apple Books library database.
    ];

    calendarReminders.user = [
      "com.apple.calaccessd" # Calendar database/access daemon.
      "com.apple.remindd" # Reminders database/sync daemon.
      "com.apple.dataaccess.dataaccessd" # Background sync for calendar and contacts with non-iCloud servers (Google, Exchange).
    ];

    contacts.user = [
      "com.apple.avatarsd" # Contact avatars/Memoji assets.
      "com.apple.contacts.donation-agent" # Donates contact interactions to suggestions/search.
      "com.apple.contacts.postersyncd" # Contact Poster sync.
      "com.apple.PosterBoard" # Contact Poster rendering/cache service.
      "com.apple.UserPictureSyncAgent" # Account/user picture sync.
    ];

    # AirDrop, Handoff, Universal Clipboard, Sidecar, Apple Watch companion
    continuity = {
      user = [
        "com.apple.rapportd-user" # Rapport proximity channel for Handoff/AirDrop-like device discovery.
        "com.apple.rapportd" # Rapport proximity channel; also runs in gui/501 on Tahoe 26+.
        "com.apple.RapportUIAgent" # UI agent for nearby-device Continuity prompts.
        "com.apple.sharingd" # AirDrop, Handoff, Universal Clipboard, and sharing services.
        "com.apple.sidecar-hid-relay" # Sidecar input relay from iPad.
        "com.apple.sidecar-relay" # Sidecar display/session relay.
        "com.apple.sidecar-display-agent" # Sidecar display session agent.
        "com.apple.remotecompositorclientd" # Remote compositor client for Sidecar display.
        "com.apple.companiond" # Apple Watch/iPhone companion device coordination.
        "com.apple.cmio.ContinuityCaptureAgent" # Continuity Camera: iPhone as webcam.
        "com.apple.cmio.LaunchCMIOUserExtensionsAgent" # Loads CMIO camera extensions (Continuity Camera path).
        "com.apple.BTServer.cloudpairing" # Bluetooth cloud pairing (syncs BT device pairings via iCloud).
        "com.apple.cdpd" # Connected Device Platform: cross-device activity and ecosystem sync.
        "com.apple.ecosystemagent" # User-facing Apple ecosystem coordination agent.
      ];
      system = [
        "com.apple.rapportd" # System Rapport service for nearby-device discovery.
        "com.apple.ecosystemd" # System Apple ecosystem services daemon.
      ];
    };

    diagnosticUpload.system = [
      "com.apple.SubmitDiagInfo" # Uploads diagnostics/crash reports to Apple.
      "com.apple.tailspind" # Captures tailspin performance traces for diagnostics.
      "com.apple.tracd" # System trace collection daemon.
      "com.apple.pcapd" # Packet-capture helper used by diagnostics/sysdiagnose.
    ];

    exchange.user = [
      "com.apple.exchange.exchangesyncd" # Exchange/ActiveSync calendar, contacts, and mail background sync.
      "com.apple.notes.exchangenotesd" # Notes sync via Exchange account.
    ];

    internetAccounts.user = ["com.apple.accountsd"]; # Internet Accounts daemon (Google, Exchange, Yahoo credential/sync broker).

    familyScreenTime = {
      user = [
        "com.apple.familycircled" # Family Sharing membership/account daemon.
        "com.apple.familycontrols.useragent" # Screen Time / Family Controls user agent.
        "com.apple.familynotificationd" # Family Sharing notifications.
        "com.apple.ScreenTimeAgent" # Screen Time limits and reporting.
        "com.apple.macos.studentd" # Classroom/student management support.
        "com.apple.progressd" # Family/Screen Time progress notifications.
        "com.apple.UsageTrackingAgent" # App and device usage tracking for Screen Time.
      ];
      system = ["com.apple.familycontrols"]; # System Screen Time / parental-controls enforcement.
    };

    findMy = {
      user = [
        "com.apple.icloud.findmydeviced.findmydevice-user-agent" # Find My Device user agent.
        "com.apple.icloud.searchpartyuseragent" # Find My network/search party user agent.
        "com.apple.findmy.findmylocateagent" # Find My location lookup agent.
        "com.apple.findmymacmessenger" # Find My Mac messaging bridge.
      ];
      system = [
        "com.apple.findmymacmessenger" # System Find My Mac messaging bridge.
        "com.apple.findmymacd" # Find My Mac / Activation Lock support.
        "com.apple.findmy.findmybeaconingd" # Find My Bluetooth beaconing.
        "com.apple.icloud.findmydeviced" # Find My Device system daemon.
        "com.apple.icloud.searchpartyd" # Find My network/search party daemon.
      ];
    };

    gameCenter = {
      user = [
        "com.apple.gamed" # Game Center account/session daemon.
        "com.apple.gamecontroller.ConfigService" # Game controller configuration UI/service.
        "com.apple.GameController.gamecontrolleragentd" # Per-user game controller agent.
        "com.apple.GameOverlayUI" # Game Center overlay UI.
        "com.apple.GamePolicyAgent" # User game policy enforcement.
        "com.apple.gamesaved" # Game save sync/storage.
      ];
      system = [
        "com.apple.GameController.gamecontrollerd" # System game controller daemon.
        "com.apple.gamepolicyd" # System game policy daemon.
        "com.apple.fpsd.arcadeservice" # Apple Arcade/fair-play support.
      ];
    };

    handwriting.system = ["com.apple.handwritingd"]; # Handwriting recognition service for trackpad/stylus input.

    homeKit = {
      user = [
        "com.apple.homed" # HomeKit home database/accessory control.
        "com.apple.homeenergyd" # Home energy accessory reporting.
        "com.apple.homeeventsd" # HomeKit automation/event handling.
        "com.apple.ThreadCommissionerService" # Thread/Matter accessory commissioning.
      ];
      system = ["com.apple.threadradiod"]; # Thread radio support for Matter/HomeKit.
    };

    icloud = {
      user = [
        "com.apple.cloudd" # Core iCloud/CloudKit sync daemon; broad app data impact.
        "com.apple.cloudpaird" # iCloud device pairing/keychain trust support.
        "com.apple.cloudphotod" # iCloud Photos sync.
        "com.apple.CloudSettingsSyncAgent" # Syncs system/app settings via iCloud.
        "com.apple.icloudmailagent" # iCloud Mail background agent.
        "com.apple.iCloudNotificationAgent" # iCloud push notification agent.
        "com.apple.iCloudUserNotifications" # User-facing iCloud notifications.
        "com.apple.protectedcloudstorage.protectedcloudkeysyncing" # Protected CloudKit/keychain key sync; disabling can break iCloud Keychain.
        "com.apple.security.cloudkeychainproxy3" # iCloud Keychain proxy; disabling can break password/keychain sync.
        "com.apple.AOSHeartbeat" # Apple Online Services heartbeat for iCloud account presence.
        "com.apple.AOSPushRelay" # Apple Online Services push relay for iCloud updates.
        "com.apple.replicatord" # Device-to-device data replication routed through iCloud infrastructure.
        "com.apple.bird" # iCloud Drive file provider daemon.
        "com.apple.syncdefaultsd" # Syncs NSUserDefaults across devices via iCloud.
      ];
      system = ["com.apple.cloudd"]; # System CloudKit/iCloud daemon.
    };

    # iMessage + FaceTime backbone. Default false — user may rely on Messages.app.
    iMessage.user = [
      "com.apple.callhistoryd" # Phone/FaceTime call history database.
      "com.apple.CallHistoryPluginHelper" # Call history plugin helper.
      "com.apple.CallHistorySyncHelper" # Syncs call history across devices.
      "com.apple.facetimemessagestored" # FaceTime messages/storage backend.
      "com.apple.idsfoundation.IDSRemoteURLConnectionAgent" # IDS/iMessage remote connection transport.
      "com.apple.imagent" # Messages/iMessage account and routing agent.
      "com.apple.imautomatichistorydeletionagent" # Messages automatic history deletion.
      "com.apple.imcore.imtransferagent" # Messages attachment/file transfer.
      "com.apple.imdpersistence.IMDPersistenceAgent" # Messages database persistence.
      "com.apple.keychainsharingmessagingd" # Keychain sharing via Messages.
      "com.apple.mediacontinuityd" # FaceTime/media Continuity handoff.
      "com.apple.nexusd" # Messages/FaceTime service coordination.
      "com.apple.securemessagingagent" # Secure messaging cryptographic support.
      "com.apple.avconferenced" # FaceTime/audio-video conferencing backend.
    ];

    telephony.user = [
      "com.apple.telephonyutilities.callservicesd" # Phone/FaceTime call services; broader than iMessage.
      "com.apple.CommCenter-osx" # Cellular/SMS/telephony continuity backend; broader than iMessage.
    ];

    mail.user = ["com.apple.email.maild"]; # Mail.app background fetch/push daemon.

    location = {
      user = [
        "com.apple.geod" # Geocoding/location lookup; also runs in gui/501 on Tahoe 26+.
        "com.apple.CoreLocationAgent" # User Location Services agent; affects auto time zone and location prompts.
        "com.apple.geodMachServiceBridge" # Bridge between geod and client apps.
        "com.apple.Maps.pushdaemon" # Maps push notifications.
        "com.apple.Maps.mapssyncd" # Maps favorites/recents sync.
        "com.apple.maps.destinationd" # Maps destination prediction/suggestions.
        "com.apple.navd" # Navigation/routing daemon.
      ];
      system = ["com.apple.locationd"]; # Core system Location Services daemon.
      user205 = ["com.apple.geod"]; # Pre-login geocoding helper used by locationd.
    };

    mdm.user = ["com.apple.ManagedClientAgent.enrollagent"]; # MDM enrollment agent.

    mobileDevice.user = [
      "com.apple.mobiledeviceupdater" # Updates firmware on connected iOS/iPadOS devices.
      "com.apple.MobileAccessoryUpdater.fudHelperAgent" # Firmware update helper for MFi accessories.
      "com.apple.mobilerepaird" # Self-repair/diagnostics agent for connected mobile devices.
      "com.apple.ptpcamerad" # PTP camera import from connected iOS devices.
      "com.apple.CoreDevice.remotepairingd" # Remote device pairing for Xcode/Instruments over the network.
    ];

    media.user = [
      "com.apple.mediaanalysisd" # Photos/video visual analysis and memories/object detection.
      "com.apple.mediastream.mstreamd" # Legacy Photo Stream / media stream sync.
      "com.apple.photoanalysisd" # Photos face/object analysis.
      "com.apple.photolibraryd" # Photos library database/background sync.
      "com.apple.shazamd" # Shazam/music recognition service.
      "com.apple.sportsd" # Apple Sports live activity/data service.
      "com.apple.amsengagementd" # Apple Media Services engagement/promotions.
      "com.apple.amsondevicestoraged" # Apple Media Services on-device storage/cache.
      "com.apple.stickersd" # Stickers/Memoji media service.
    ];

    # Apple Music / AirPlay / AMP stack. Default false — terminal users who use
    # Spotify/mpv may still want system audio infra intact.
    mediaPlayer = {
      user = [
        "com.apple.AirPlayUIAgent" # AirPlay target/device UI.
        "com.apple.AMPArtworkAgent" # Apple Music/Media artwork cache.
        "com.apple.AMPDeviceDiscoveryAgent" # Apple Media Player device discovery.
        "com.apple.AMPDevicesAgent" # Apple Media Player device management.
        "com.apple.AMPLibraryAgent" # Apple Music/Media library database.
        "com.apple.amp.mediasharingd" # Home Sharing / media library sharing.
        "com.apple.AMPSystemPlayerAgent" # Apple Music system player integration.
        "com.apple.amsaccountsd" # Apple Media Services account daemon.
        "com.apple.itunescloudd" # Music/iTunes cloud library sync.
        "com.apple.mediaremoteagent" # Now Playing/media keys/remote control; may affect keyboard media controls.
        "com.apple.nowplayingtouchui" # Now Playing Touch Bar/menu UI.
        "com.apple.voicememod" # Voice Memos recording/library daemon.
        "com.apple.tonelibraryd" # Ringtones/alert tones library service.
      ];
      system = ["com.apple.musicd"]; # System Apple Music/media daemon.
    };

    mlRuntime.user = [
      "com.apple.mlhostd" # Per-user Core ML model host.
      "com.apple.mlruntimed" # Core ML runtime daemon.
      "com.apple.ModelCatalogAgent" # Downloads/catalogs ML model assets.
    ];

    networking = {
      user = [
        "com.apple.AirPortBaseStationAgent" # AirPort router/base-station management; networking, not media playback.
      ];
      system = [
        "com.apple.ftp-proxy" # Legacy FTP proxy support.
        "com.apple.netbiosd" # NetBIOS/SMB name discovery; keep for Windows/Samba network browsing.
      ];
    };

    nearbyInteraction.system = ["com.apple.nearbyd"]; # Nearby device discovery and interaction; requires multiple Apple devices.

    news.user = [
      "com.apple.newsd" # Apple News background sync/notifications.
      "com.apple.tipsd" # Apple Tips content/notifications.
    ];

    podcasts.user = ["com.apple.podcasts.PodcastContentService"]; # Apple Podcasts download/library service.

    quickLook.user = [
      "com.apple.quicklook" # Finder/Spotlight file preview generation.
      "com.apple.quicklook.ui.helper" # Quick Look preview UI helper.
      "com.apple.quicklook.ThumbnailsAgent" # Finder thumbnail generation; disabling leaves generic icons/previews.
    ];

    remoteDesktop = {
      user = [
        "com.apple.RemoteDesktop.agent" # Apple Remote Desktop client agent.
        "com.apple.RemoteManagementAgent" # Remote Management/ARD user agent.
      ];
      system = [
        "com.apple.remotemanagementd" # System Remote Management / ARD daemon.
        "com.apple.remoted" # Remote control protocol daemon.
      ];
    };

    safari.user = [
      "com.apple.Safari.History" # Safari history database service.
      "com.apple.SafariHistoryServiceAgent" # Safari history sync/maintenance.
      "com.apple.SafariLaunchAgent" # Safari background launch/warm service.
      "com.apple.SafariNotificationAgent" # Safari website notifications.
      "com.apple.Safari.PasswordBreachAgent" # Safari compromised-password checks.
      "com.apple.Safari.SafeBrowsing.Service" # Safari safe browsing database/checks.
      "com.apple.SafariBookmarksSyncAgent" # Safari bookmark sync.
    ];

    # Default false — screen sharing is useful on-demand.
    screenSharing = {
      user = [
        "com.apple.screensharing.agent" # Screen Sharing/VNC user agent.
        "com.apple.screensharing.menuextra" # Screen Sharing menu extra.
        "com.apple.screensharing.MessagesAgent" # Messages-based screen-sharing invites.
        "com.apple.SSInvitationAgent" # Screen Sharing invitation agent.
      ];
      system = ["com.apple.screensharing"]; # System Screen Sharing service.
    };

    serverProtocols.system = [
      "com.apple.afpfs_afpLoad" # Legacy AFP network filesystem loader.
      "com.apple.afpfs_checkafp" # Legacy AFP mount checker.
      "com.apple.avbdeviced" # Audio Video Bridging device/network service.
      "com.apple.nfcd" # Near-field communication daemon.
      "com.apple.nfsd" # NFS server daemon.
      "com.apple.nfsconf" # NFS configuration helper.
      "com.apple.postfix.master" # Local Postfix SMTP master daemon.
      "com.apple.postfix.newaliases" # Postfix aliases database rebuild helper.
    ];

    shortcuts.user = ["com.apple.WorkflowKit.ShortcutsViewService"]; # Shortcuts app/workflow view service.

    # Focus modes (DND) and Live Activities / Dynamic Island widgets.
    focus.user = [
      "com.apple.donotdisturbd" # Focus / Do Not Disturb mode enforcement and scheduling.
      "com.apple.liveactivitiesd" # Live Activities runtime (lock screen / Dynamic Island widgets).
      "com.apple.StatusKitAgent" # Status Kit agent powering Live Activities updates.
    ];

    systemServices.user = [
      "com.apple.helpd" # In-app help viewer (macOS Help books and guided tours).
      "com.apple.chronod" # Widget runtime and widget-centre connectivity.
      "com.apple.recentsd" # Recent items tracking (Finder recent files/apps).
      "com.apple.SoftwareUpdateNotificationManager" # macOS software update notification agent.
    ];

    social.user = ["com.apple.sociallayerd"]; # Social/share-sheet account integration.

    # WARNING: disabling metadata.mds breaks Finder search and many apps.
    # Default false for safety.
    spotlight.system = ["com.apple.metadata.mds"]; # Core Spotlight metadata indexer; disabling breaks Finder/search/launcher workflows.

    spellCheck.user = ["com.apple.applespell"]; # System spell-check service used by Cocoa text fields/apps.

    timeMachine = {
      user = ["com.apple.TMHelperAgent"]; # Time Machine user helper/menu integration.
      system = [
        "com.apple.backupd" # Time Machine backup daemon.
        "com.apple.backupd-helper" # Time Machine backup helper.
      ];
    };

    translation.user = ["com.apple.translationd"]; # System Translate service.

    trial = {
      user = [
        "com.apple.triald" # Apple feature trials/experiments daemon.
        "com.apple.betaenrollmentagent" # macOS beta enrollment agent.
      ];
      system = ["com.apple.triald.system"]; # System feature trials/experiments daemon.
    };

    tvVideo.user = [
      "com.apple.videosubscriptionsd" # TV/video subscription entitlement sync.
      "com.apple.watchlistd" # Apple TV watchlist/up-next sync.
    ];

    weather.user = [
      "com.apple.weatherd" # Weather data/notification service.
      "com.apple.weather.menu" # Weather menu bar agent.
    ];
  };

  # ── Domain helpers ────────────────────────────────────────────────────────────
  domainStr = {
    user = "gui/501";
    system = "system";
    user205 = "user/205";
  };

  # All services known to this module for a given domain key
  allKnown = domainKey:
    lib.unique (lib.concatLists (
      lib.mapAttrsToList (_: grp: grp.${domainKey} or []) groups
    ));

  # Final disable list for a domain: enabled groups + extras, minus carve-outs
  toDisable = domainKey:
    lib.unique (
      lib.subtractLists cfg.extra.enable (
        lib.concatLists (
          lib.mapAttrsToList (
            name: grp:
              if cfg.disable.${name}
              then grp.${domainKey} or []
              else []
          )
          groups
        )
        ++ cfg.extra.disable.${domainKey}
      )
    );

  # Re-enable list: known services not being disabled (declarative round-trip)
  toEnable = domainKey:
    lib.unique (
      lib.subtractLists (toDisable domainKey) (allKnown domainKey)
      ++ cfg.extra.enable
    );

  mkDomainScript = domainKey: let
    domain = domainStr.${domainKey};
    disableSvcs = toDisable domainKey;
    enableSvcs = toEnable domainKey;
    nDisable = toString (builtins.length disableSvcs);
    nEnable = toString (builtins.length enableSvcs);
  in ''
    echo "  [${domain}] disabling ${nDisable}, re-enabling ${nEnable}"
    ${lib.concatMapStrings (svc: ''
        echo "    - ${svc}"
        launchctl bootout ${domain}/"${svc}" 2>/dev/null || true
        launchctl disable ${domain}/"${svc}" || true
      '')
      disableSvcs}
    ${lib.concatMapStrings (svc: ''
        echo "    + ${svc}"
        launchctl enable ${domain}/"${svc}" 2>/dev/null || true
      '')
      enableSvcs}
  '';
in {
  # ── Options ───────────────────────────────────────────────────────────────────
  options.system.daemonBuster = {
    enable = mkEnableOption "daemon-buster — disable unwanted macOS background services";

    # One boolean per group, auto-generated from the groups attrset above.
    # All groups default to false — nothing is disabled unless the host config opts in.
    disable =
      lib.mapAttrs (
        _: _:
          mkOption {
            type = types.bool;
            default = false;
            description = "Disable this service group. Set true to stop and persist-disable its services.";
          }
      )
      groups;

    extra = {
      disable = {
        user = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "Additional gui/501 (user) services to disable individually.";
        };
        system = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "Additional system services to disable individually.";
        };
        user205 = mkOption {
          type = types.listOf types.str;
          default = [];
          description = "Additional user/205 (pre-login) services to disable individually.";
        };
      };
      enable = mkOption {
        type = types.listOf types.str;
        default = [];
        description = ''
          Service names to carve out from all disable groups across all domains.
          Any name listed here is guaranteed to be re-enabled, overriding group settings.
        '';
        example = lib.literalExpression ''["com.apple.CoreLocationAgent"]'';
      };
    };
  };

  # ── Activation ────────────────────────────────────────────────────────────────
  config = mkIf cfg.enable {
    system.activationScripts.daemonBuster.text = ''
      echo "daemon-buster: configuring launchd service state…"
      ${mkDomainScript "system"}
      ${mkDomainScript "user"}
      ${mkDomainScript "user205"}
      echo "daemon-buster: done"
    '';
  };
}
