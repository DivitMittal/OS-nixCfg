#!/bin/bash

printf "\033[0;33m"
printf "\n#######################"
printf "\nD's macOS SETUP"
printf "\n#######################"
printf "\033[0m\n"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################
# System
###############################################################

# set default macOS metrics
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Disable Sudden Motion Sensor
sudo pmset -a sms 0

# Sleep the display in minutes
sudo pmset -a displaysleep 10

# Machine sleep while charging in minutes
sudo pmset -c sleep 30

# Set machine sleep on battery in minutes
sudo pmset -b sleep 15

# Wake from sleep when opening lid; disabled(0)
# sudo pmset lidwake 0

# Seconds after which the screen saver shows up
defaults -currentHost write com.apple.screensaver idleTime 300

# reduceTransparency in the current user system-wide
# defaults write com.apple.universalaccess reduceTransparency 1

# Disable Auto-boot on lid-open and power connection
sudo nvram AutoBoot=%00
# Reset nvram or run this command ( sudo nvram AutoBoot=%03 ) to revert changes made by above command

# Verbose boot
sudo nvram boot-args=“-v”

###################################################
# Screenshots
###################################################

# Save screenshots to the a location specified in the string
# defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in JPEG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "jpg"

# Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

#################################################################
# Sound
#################################################################

# Increase sound quality for Bluetooth headphones/headsets
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable audio feedback when volume is changed
# defaults write com.apple.sound.beep.feedback -bool false

#####################################################
# Keyboard
#####################################################

# Enable key repeat on press and hold instead of various similar characters
defaults write -g ApplePressAndHoldEnabled -bool false
# to restore above settings changed above
# defaults delete -g ApplePressAndHoldEnabled

# First key repeat delay, default is 15 (225 ms); 1 = 15ms
defaults write -g InitialKeyRepeat -float 35
# or
# defaults write -g InitialKeyRepeat -float 10.0

# Subsequent key repeat delay, default is 2 (30 ms); 1 = 15ms
# defaults write NSGlobalDomain KeyRepeat -float 1.5
# or
defaults write -g KeyRepeat -float 1.0

# Hides the dialog box that appears for Dictation on multiple fn key presses
defaults write com.apple.HIToolbox AppleDictationAutoEnable -int 1

# Enable full keyboard access for all controls, i.e, enable Tab in modal dialogs
# defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes and dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###################################################################
# Trackpad
###################################################################

# System Preferences > Accessibility > Mouse & Trackpad > Trackpad Potions
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: swipe between pages with three fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Disable the Launchpad gesture (pinch with thumb and three fingers)
#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

#################################################################
# Mission Control & Launhpad
#################################################################

# Speed up Mission Control animations
# defaults write com.apple.dock expose-animation-duration -float 0

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
# defaults write com.apple.dock expose-group-by-app -bool false

# Disable Dashboard
# defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
# defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Instantaneous showing and hiding Launchpad
#defaults write com.apple.dock springboard-show-duration -float 0
#defaults write com.apple.dock springboard-hide-duration -float 0

# Instantaneous changing pages in Launchpad
#defaults write com.apple.dock springboard-page-duration -float 0

##########################################################################
# Finder
##########################################################################

# Set default new window finder location to home directory
# Home - PfHm
# Desktop - PfDe
# Documents - PfDo
defaults write com.apple.finder NewWindowTargetPath -string "PfHm"

# Finder > Preferences > Show warning before removing from iCloud Drive
# defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
# defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true

# Always open everything in Finder's icon view.
# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: Show path bar
# defaults write com.apple.finder ShowPathbar -bool true

# Finder: Hide show status bar
# defaults write com.apple.finder ShowStatusBar -bool false

# Show the ~/Library folder
sudo chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Show item info near icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Show item info to the right of the icons on the desktop
# /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
#
# Finder: allow quitting via ⌘ + Q
# defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
# defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Expand save panel by default
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
# defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable opening and closing window animations
# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
# float 0 doesn't work
# defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Opening and closing Quick Look windows animation duration
# defaults write -g QLPanelAnimationDuration -float 0

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Disable showing menu bar in full screen
defaults write -g NSToolbarFullScreenAnimationDuration -float 0

# Hide Scrollbars
defaults write -g AppleShowScrollBars -string “Never”

# Disable rubberband scrolling animation (doesn't affect web views)
defaults write -g NSScrollViewRubberbanding -bool false

# Setting another file manager as default file manager (in this case ForkLift 3)
# defaults write -g NSFileViewer -string com.binarynights.ForkLift-3;
# Setting default file explorer launch service to ForkLift 3
# defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.binarynights.ForkLift";}'

# Revert Finder as deault file explorer and launch service for file explorer
# defaults delete -g NSFileViewer
# defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.apple.finder";}'

#################################################################
# Dock & Menu Bar
#################################################################

# To Enable Autohide Dock
defaults write com.apple.dock autohide -bool true

# To Autohide Menu Bar
# defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Make dock appear instantaneously, if hidden
# defaults write com.apple.dock autohide-delay -float 0

# Disables application bouncing animation
# defaults write com.apple.dock no-bouncing -bool true

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# System Preferences > Dock > Size:
defaults write com.apple.dock tilesize -int 14

# System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool true

# System Preferences > Dock > Size (magnified):
defaults write com.apple.dock largesize -int 64

# System Preferences > Dock > Minimize windows using: Scale effect/Genie effect
# defaults write com.apple.dock mineffect -string "scale"

# System Preferences > Dock > Minimise windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Change Dock orientation to right
defaults write com.apple.dock orientation right

# For changes made above to take effect
killall Dock

###############################################################################
# Activity monitor, TextEdit, DiskUtility, Photos, AppStore
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualise CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
# defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
# defaults write com.apple.ActivityMonitor SortDirection -int 0

# Use plain text mode for new TextEdit documents instead of RTF
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Turn Spotlight Off (in case of utilisation of alternate tools, eg. Raycast)
sudo mdutil -a -i off
# Also, disable all spotlight indexing and add root directory as an exception from System Preferences

echo "Done. Note that some of these changes require a logout/restart/killall to take effect."
