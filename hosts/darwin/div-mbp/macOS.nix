_:

{
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock = {
      ### Dock
      autohide        = true;
      orientation     = "right";
      persistent-apps = [];
      static-only     = true; show-recents = false; show-process-indicators = false; showhidden = true;
      tilesize        = 20; magnification  = true; largesize                = 64; minimize-to-application = false; mineffect = "genie";
      ### Spaces
      mru-spaces      = false;
      ### Hot-Corners
      wvous-bl-corner = 1; wvous-br-corner = 1; wvous-tl-corner = 10; wvous-tr-corner = 13;
    };

    finder = {
      QuitMenuItem                   = false;
      AppleShowAllFiles              = true; AppleShowAllExtensions = true;
      ShowPathbar                    = true; ShowStatusBar          = false; _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
      FXDefaultSearchScope           = "SCcf"; # SCcf - Scope current folder
      FXPreferredViewStyle           = "icnv"; # icnv - icnv
    };

    loginwindow = {
      GuestEnabled         = false;
      DisableConsoleAccess = false;
    };

    NSGlobalDomain = {
      AppleMetricUnits       = 1; AppleMeasurementUnits = "Centimeters"; AppleTemperatureUnit = "Celsius";
      AppleWindowTabbingMode = "always";
      ### UI
      AppleInterfaceStyle = "Dark"; AppleInterfaceStyleSwitchesAutomatically = false;
      _HIHideMenuBar      = false;
      AppleShowScrollBars = "WhenScrolling";
      AppleFontSmoothing = 2;
      ### Keyboard
      ApplePressAndHoldEnabled     = false;
      InitialKeyRepeat             = 14;         # First key repeat delay, default is 15 (225 ms); 1           = 15ms
      KeyRepeat                    = 1;          # Subsequent key repeat delay, default is 2 (30 ms); 1 = 15ms
      AppleKeyboardUIMode          = 3;
      NSTextShowsControlCharacters = true;
      "com.apple.keyboard.fnState" = false;      # media/control/function keys will default to function keys
      NSAutomaticCapitalizationEnabled     = false; NSAutomaticDashSubstitutionEnabled   = false; NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled  = false; NSAutomaticSpellingCorrectionEnabled = false;
      ### Mouse/Trackpad
      "com.apple.mouse.tapBehavior"                    = 1;
      "com.apple.swipescrolldirection"                 = true; # natural scrolling
      "com.apple.trackpad.scaling"                     = 1.75;
      "com.apple.trackpad.enableSecondaryClick"        = true; "com.apple.trackpad.trackpadCornerClickBehavior" = null;
      NSWindowShouldDragOnGesture                      = true;
      ### UX
      "com.apple.sound.beep.feedback" = 1; "com.apple.sound.beep.volume"   = 0.3;
    };

    trackpad = {
      Clicking                = true;  TrackpadRightClick   = true;    # tap-to-click
      FirstClickThreshold     = 0;     SecondClickThreshold = 2;       # force touch left click thresholds
      Dragging                = false;   # tap-to-drag
      TrackpadThreeFingerDrag = true;
    };

    LaunchServices.LSQuarantine = false;
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  };

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      WebKitDeveloperExtras = true;       # Add a context menu item for showing the Web Inspector in web views
    };
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    "com.apple.ImageCapture".disableHotPlug = true; # Auto
    "com.apple.commerce".AutoUpdate = true;
    "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
    };
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "com.apple.screensaver" = {
      askForPassword = 1;
      askForPasswordDelay = 0;
    };
    "com.apple.Safari" = {
      UniversalSearchEnabled = false;  # Privacy: don’t send search queries to Apple
      SuppressSearchSuggestions = true;
      WebKitTabToLinksPreferenceKey = true; # Press Tab to highlight each item on a web page
      ShowFullURLInSmartSearchField = true;
      AutoOpenSafeDownloads = false;  # Prevent Safari from opening ‘safe’ files automatically after downloading
      ShowFavoritesBar = false;
      IncludeInternalDebugMenu = true;
      IncludeDevelopMenu = true;
      WebKitDeveloperExtrasEnabledPreferenceKey = true;
      WebContinuousSpellCheckingEnabled = false;
      WebAutomaticSpellingCorrectionEnabled = false;
      AutoFillFromAddressBook = false;
      AutoFillCreditCardData = false;
      AutoFillMiscellaneousForms = false;
      WarnAboutFraudulentWebsites = true;
      WebKitJavaEnabled = false;
      WebKitJavaScriptCanOpenWindowsAutomatically = false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
    };
    "com.apple.screencapture" = {
      location = "~/Pictures/Screenshots/";
      type = "png";
    };
    "com.apple.TextEdit".RichText = false;
    "com.apple.HIToolbox".AppleFnUsageType = 0; # fn key does nothing
    "com.apple.appleseed.FeedbackAssistant".Autogather = false;
  };
}