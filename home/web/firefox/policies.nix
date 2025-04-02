_:

{
  policies = {
    AppAutoUpdate = false; # Disable automatic application update
    BackgroundAppUpdate = false; # Disable automatic application update in the background, when the application is not running.
    DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
    DisableBuiltinPDFViewer = false;
    DisableFirefoxStudies = true;
    DisableFirefoxAccounts = false; # Enable Firefox Sync
    DisablePocket = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    OfferToSaveLogins = false; # Managed by bitwarden
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
      EmailTracking = true;
      # Exceptions = ["https://example.com"]
    };
    ExtensionUpdate = false;
  };
}