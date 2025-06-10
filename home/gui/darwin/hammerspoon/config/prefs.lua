hs.ipc.cliInstall() -- installs `hs` binary @ /usr/local/bin with ownership div:admin
hs.ipc.cliSaveHistory(false)

-- enabled
hs.autoLaunch(true)
hs.menuIcon(true)
hs.preferencesDarkMode(true)
hs.allowAppleScript(true)
hs.accessibilityState(true)

-- disabled
hs.dockIcon(false)
hs.automaticallyCheckForUpdates(false)
hs.uploadCrashData(false)