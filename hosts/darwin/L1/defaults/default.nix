{config, ...}: {
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = 1.75;
    };

    NSGlobalDomain = {
      AppleMetricUnits = 1;
      AppleMeasurementUnits = "Centimeters";
      AppleTemperatureUnit = "Celsius";
      ## Finder
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSTableViewDefaultSizeMode = 2; # 1 = Small, 2 = Medium, 3 = Large (sidebar icons)
      "com.apple.springing.enabled" = false;
      ## Windows
      AppleWindowTabbingMode = "manual";
      NSAutomaticWindowAnimationsEnabled = false;
      NSWindowShouldDragOnGesture = true;
      ## UI
      _HIHideMenuBar = false;
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      NSTextShowsControlCharacters = true;
      PMPrintingExpandedStateForPrint = true;
      AppleShowScrollBars = "WhenScrolling";
      #AppleFontSmoothing = 2;
      ## Keyboard
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15; # First key repeat delay, default is 15 (225 ms); 1 = 15ms
      KeyRepeat = 1; # Subsequent key repeat delay, default is 2 (30 ms); 1 = 15ms
      AppleKeyboardUIMode = 2; # 0 = Disabled 2 = Enabled on Sonoma or later 3 = Enabled on older macOS versions
      "com.apple.keyboard.fnState" = false; # media/control/function keys will default to function keys
      ## Autocorrect
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      ## Mouse/Trackpad
      "com.apple.mouse.tapBehavior" = 1; # tap to click
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.forceClick" = true;
      "com.apple.swipescrolldirection" = true; # natural scrolling
      "com.apple.trackpad.scaling" = 1.75;
      "com.apple.trackpad.trackpadCornerClickBehavior" = null;
      ## UX
      "com.apple.sound.beep.feedback" = 1;
      "com.apple.sound.beep.volume" = 0.3;
    };

    ## Stage Manager
    WindowManager = {
      GloballyEnabled = false;
      AppWindowGroupingBehavior = true; # false means “One at a time” true means “All at once”
      EnableStandardClickToShowDesktop = true;
    };

    ## Control Center
    controlcenter = {
      AirDrop = false;
      Bluetooth = true;
      NowPlaying = false;
      Sound = true;
    };

    ## Dock
    dock = {
      ## Autohide
      autohide = true;
      autohide-delay = 0.175;
      autohide-time-modifier = 1.5;
      ## Mission Control
      expose-animation-duration = 1.5;
      expose-group-apps = false;
      ## UI
      mouse-over-hilite-stack = true;
      orientation = "right";
      show-process-indicators = false;
      showhidden = true;
      minimize-to-application = false;
      ## Animation
      launchanim = false;
      tilesize = 20;
      largesize = 64;
      magnification = true;
      mineffect = "genie";
      ## Items
      persistent-apps = [];
      static-only = true; # only open apps
      show-recents = false;
      ## Spaces
      mru-spaces = false; # most-recently used spaces ordering
      ## Hot-Corners
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 10;
      wvous-tr-corner = 13;
    };

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      ShowPathbar = true;
      NewWindowTarget = "Home";
      ShowStatusBar = false;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
      _FXShowPosixPathInTitle = true;
      FXRemoveOldTrashItems = true; # Remove items from the Trash after 30 days
      FXEnableExtensionChangeWarning = false;
      FXDefaultSearchScope = "SCcf"; # SCcf(SCope current folder)
      FXPreferredViewStyle = "icnv";
    };

    ## HID
    hitoolbox = {
      AppleFnUsageType = "Do Nothing";
    };

    iCal = {
      "first day of week" = "Monday";
    };

    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = false; # typing “>console” for a username
      PowerOffDisabledWhileLoggedIn = false;
      RestartDisabled = false;
      RestartDisabledWhileLoggedIn = false;
      ShutDownDisabled = false;
      ShutDownDisabledWhileLoggedIn = false;
      SleepDisabled = false;
      autoLoginUser = "${config.hostSpec.username}";
    };

    menuExtraClock = {
      FlashDateSeparators = false; # Do not flash the date separators for every second
      IsAnalog = false; # Show clock as analog
      Show24Hour = false;
      ShowAMPM = true;
      ShowDate = 1; # 0 = when space, 1 = always, 2 = never
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = false;
    };

    screencapture = {
      location = "~/Pictures/Screenshots/";
      type = "png"; # png, jpg, tiff, pdf, ps, eps
      disable-shadow = true; # Disable shadow in screenshots
      show-thumbnail = false; # Do not show a thumbnail of the screenshot in the corner of the screen
    };

    screensaver = {
      askForPassword = true; # Require password after sleep or screen saver begins
      askForPasswordDelay = 0; # Immediately require password
    };

    trackpad = {
      ActuationStrength = 0; # Force Touch actuation strength
      Clicking = true; # tap-to-click
      TrackpadRightClick = true; # two-finger right click
      FirstClickThreshold = 0; # force touch left click thresholds
      SecondClickThreshold = 0; # force touch right click thresholds
      Dragging = false; # tap-to-drag
      TrackpadThreeFingerDrag = true;
      TrackpadThreeFingerTapGesture = 2;
    };

    LaunchServices.LSQuarantine = false;
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  };

  system.defaults.CustomSystemPreferences = {
    ## Image Capture
    "com.apple.ImageCapture".disableHotPlug = true; # Auto
    ## Ads
    "com.apple.AdLib" = {
      allowApplePersonalizedAdvertising = false;
      StocksEnabled = false;
      allowIdentifierForAdvertising = false;
    };
    ## Desktop Services
    "com.apple.desktopservices" = {
      # Avoid creating .DS_Store files on network or USB volumes
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    ## HID
    "com.apple.HIToolbox" = {
      AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.ABC";
      AppleDictationAutoEnable = 0;
    };
    ## Text Edit
    "com.apple.TextEdit".RichText = false;
    ## Feedback Assistant
    "com.apple.appleseed.FeedbackAssistant".Autogather = false;
    ## TimeMachine
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    ## App Store
    "com.apple.commerce".AutoUpdate = false;
  };

  system.defaults.CustomUserPreferences = {
    NSGlobalDomain = {
      AppleLocale = "en_US@currency=USD";
      AppleLanguages = ["en"];
      AppleAccentColor = 0;
      AppleHighlightColor = "1.000000 0.733333 0.721569 Red";
      AppleMenuBarFontSize = "large";
    };

    ## Accessibility
    "com.apple.universalaccess" = {
      contrast = "0.04";
      cursorIsCustomized = 1;
      cursorFill = {
        alpha = 1;
        blue = 0;
        green = 0;
        red = 0;
      };
      cursorOutline = {
        alpha = 1;
        blue = 0;
        green = 0.15;
        red = 1;
      };
    };

    ## Touchbar
    "com.apple.controlstrip" = {
      FullCustomized = [
        "com.apple.system.sleep"
        "com.apple.system.screen-saver"
        "com.apple.system.screen-lock"
        "NSTouchBarItemIdentifierFlexibleSpace"
        "com.apple.system.group.keyboard-brightness"
        "com.apple.system.group.media"
      ];
      MiniCustomized = [
        "com.apple.system.brightness"
        "com.apple.system.volume"
        "com.apple.system.mute"
      ];
    };

    ## Safari
    NSGlobalDomain.WebKitDeveloperExtras = true; # Add a context menu item for showing the Web Inspector in web views
    "com.apple.Safari" = {
      UniversalSearchEnabled = false; # Privacy: don’t send search queries to Apple
      SuppressSearchSuggestions = true;
      WebKitTabToLinksPreferenceKey = true; # Press Tab to highlight each item on a web page
      ShowFullURLInSmartSearchField = true;
      AutoOpenSafeDownloads = false; # Prevent Safari from opening ‘safe’ files automatically after downloading
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
      "com.apple.Safari.ContentPageGroupIdentifier" = {
        WebKit2TabsToLinks = true;
        WebKit2DeveloperExtrasEnabled = true;
        WebKit2BackspaceKeyNavigationEnabled = false;
        WebKit2JavaEnabled = false;
        WebKit2JavaEnabledForLocalFiles = false;
        WebKit2JavaScriptCanOpenWindowsAutomatically = false;
      };
    };
  };
}