_: {
  system.defaults = {
    NSGlobalDomain = {
      AppleMetricUnits = 1;
      AppleMeasurementUnits = "Centimeters";
      AppleTemperatureUnit = "Celsius";
      ## Finder
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      ## Windows
      "com.apple.springing.enabled" = false;
      AppleWindowTabbingMode = "manual";
      ## UI
      NSTextShowsControlCharacters = true;
      PMPrintingExpandedStateForPrint = true;
      AppleShowScrollBars = "WhenScrolling";
      ## Autocorrect
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    ## Stage Manager
    WindowManager = {
      GloballyEnabled = false;
      AppWindowGroupingBehavior = true; # false means “One at a time” true means “All at once”
      EnableStandardClickToShowDesktop = false;
    };
    ## Finder
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = false;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
      _FXShowPosixPathInTitle = true;
      FXRemoveOldTrashItems = false; # Remove items from the Trash after 30 days
      FXEnableExtensionChangeWarning = false;
    };
    ## Calendar
    iCal = {
      "first day of week" = "Monday";
    };
    ## Login Window
    loginwindow = {
      PowerOffDisabledWhileLoggedIn = false;
      RestartDisabled = false;
      RestartDisabledWhileLoggedIn = false;
      ShutDownDisabled = false;
      ShutDownDisabledWhileLoggedIn = false;
      SleepDisabled = false;
    };
    ## Menubar Clock
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
    LaunchServices.LSQuarantine = false;
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
  };

  system.defaults.CustomSystemPreferences = {
    ## Webview
    NSGlobalDomain.WebKitDeveloperExtras = true; # Add a context menu item for showing the Web Inspector in web views
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
}