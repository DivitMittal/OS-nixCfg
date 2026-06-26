_: {
  system.daemonBuster = {
    enable = true;

    disable = {
      accessibility = true;
      ads = true;
      advertising = true;
      assetCache = true;
      analytics = true;
      appleIntelligence = true;
      applePay = true;
      biome = true;
      books = true;
      calendarReminders = true;
      contacts = true;
      continuity = true;
      diagnosticUpload = true;
      exchange = true;
      familyScreenTime = true;
      internetAccounts = true;
      focus = true;
      findMy = true;
      gameCenter = true;
      handwriting = true;
      homeKit = true;
      icloud = true;
      iMessage = true;
      location = true;
      mail = true;
      mdm = true;
      mobileDevice = true;
      media = true;
      mediaPlayer = true;
      mlRuntime = true;
      nearbyInteraction = true;
      networking = true;
      news = true;
      podcasts = true;
      quickLook = true;
      remoteDesktop = true;
      safari = true;
      screenSharing = true;
      serverProtocols = true;
      shortcuts = true;
      social = true;
      spotlight = true;
      spellCheck = true;
      systemServices = true;
      telephony = true;
      timeMachine = true;
      translation = true;
      trial = true;
      tvVideo = true;
      weather = true;
    };

    # extra.disable.user   = ["com.apple.foo"];
    # extra.disable.system = ["com.apple.bar"];
    # extra.enable         = ["com.apple.CoreLocationAgent"];
  };
}
