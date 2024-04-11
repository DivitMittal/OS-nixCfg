{
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
    FXDefaultSearchScope           = "SCcf";
    FXPreferredViewStyle           = "icnv";
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
}
