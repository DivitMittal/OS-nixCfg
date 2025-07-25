#!/usr/bin/env bash
## Disabling unwanted services on macOS Big Sur (11), macOS Monterey (12), macOS Ventura (13), macOS Sonoma (14) and macOS Sequoia (15)
## Disabling SIP is required  ("csrutil disable" from Terminal in Recovery)
## Modifications are written in /private/var/db/com.apple.xpc.launchd/ disabled.plist, disabled.501.plist
## To revert, delete /private/var/db/com.apple.xpc.launchd/ disabled.plist and disabled.501.plist and reboot; sudo rm -r /private/var/db/com.apple.xpc.launchd/*

## User (post-login)
declare -a TODISABLE
TODISABLE+=(
  #### Apple
  ### Accessibility
  ## Tracks motion for accessibility features.
  'com.apple.accessibility.MotionTrackingAgent'
  ## Loads assets for accessibility features.
  'com.apple.accessibility.axassetsd'
  ## Provides Universal Access services for accessibility features.
  'com.apple.universalaccessd'
  ## Supports the Voice Banking feature for creating a personalized synthesized voice.
  'com.apple.voicebankingd'

  ### Ads
  ## Manages privacy for Apple's advertising services.
  'com.apple.ap.adprivacyd'
  ## Handles promoted content and metrics for Apple's advertising services.
  'com.apple.ap.promotedcontentd'

  ### Analytics & Diagnostics
  ## Collects and processes geo-location analytics.
  'com.apple.geoanalyticsd'
  ## Collects diagnostics and usage data related to user input.
  'com.apple.inputanalyticsd'

  ### Apple Pay & Wallet
  ## Manages Apple Pay and Wallet services.
  'com.apple.financed'
  ## Manages passes, tickets, and payment cards in Wallet; also handles Apple Pay.
  'com.apple.passd'

  ### Biome
  ## Executes the Biome operation graph, part of a system for user activity prediction.
  'com.apple.BiomeAgent'
  ## Synchronizes Biome data across devices.
  'com.apple.biomesyncd'

  ### Calendar & Reminders
  ## Provides access to the user's calendar data.
  'com.apple.calaccessd'
  ## Manages reminders, alarms, and location-based alerts for the Reminders app.
  'com.apple.remindd'

  ### Continuity & Handoff (Sidecar, Rapport)
  ## Enables Phone Call Handoff, Universal Clipboard, and other continuity features between Apple devices.
  'com.apple.rapportd'
  ## User-specific agent for continuity features like Handoff.
  'com.apple.rapportd-user'
  ## Enables AirDrop, Handoff, Instant Hotspot, Shared Computers, and Remote Disc features.
  'com.apple.sharingd'
  ## Relays Human Interface Device (HID) events for Sidecar, allowing input from an iPad.
  'com.apple.sidecar-hid-relay'
  ## The main relay service for Sidecar, managing the virtual display connection.
  'com.apple.sidecar-relay'

  ### Family Sharing & Screen Time
  ## Manages Family Sharing information and status.
  'com.apple.familycircled'
  ## Handles and persists authorization requests for the Screen Time API as part of Family Controls.
  'com.apple.familycontrols.useragent'
  ## Manages notifications related to Family Sharing.
  'com.apple.familynotificationd'
  ## The primary agent that supports the Screen Time feature by tracking usage.
  'com.apple.ScreenTimeAgent'
  ## The agent for student devices that allows teacher control via the Classroom app.
  'com.apple.macos.studentd'
  ## Syncs student progress data for educational apps using ClassKit.
  'com.apple.progressd'
  ## Monitors application usage and reports on limits set by Screen Time.
  'com.apple.UsageTrackingAgent'

  ### Find My
  ## The daemon for the "Find My Friends" feature.
  'com.apple.icloud.fmfd'
  ## User agent for the "Find My" network's offline finding capabilities.
  'com.apple.icloud.searchpartyuseragent'
  'com.apple.findmy.findmylocateagent'

  ### Game Center
  ## The central daemon for Game Center services.
  'com.apple.gamed'

  ### HomeKit
  ## Manages home state and controls HomeKit accessories.
  'com.apple.homed'

  ### iCloud & Storage
  ## The system daemon that supports the CloudKit framework for cloud data storage.
  'com.apple.cloudd'
  ## Manages pairing of devices via iCloud.
  'com.apple.cloudpaird'
  ## Responsible for all iCloud Photos activity, including syncing.
  'com.apple.cloudphotod'
  ## Syncs various system and application settings via iCloud.
  'com.apple.CloudSettingsSyncAgent'
  ## Manages and displays notifications from iCloud.
  'com.apple.iCloudNotificationAgent'
  'com.apple.icloudmailagent'
  ## Handles user-facing notifications related to iCloud accounts.
  'com.apple.iCloudUserNotifications'
  ## Manages iCloud Music Library, subscription status, and play activity.
  'com.apple.itunescloudd'
  ## Manages the backup and syncing of encrypted Protected Cloud Storage (PCS) keys to CloudKit.
  'com.apple.protectedcloudstorage.protectedcloudkeysyncing'
  ## A proxy agent involved in syncing the iCloud Keychain.
  'com.apple.security.cloudkeychainproxy3'

  ### iMessage & FaceTime
  ## Core agent for the iMessage and FaceTime services.
  #'com.apple.imagent'
  ## Automatically deletes old iMessage history.
  'com.apple.imautomatichistorydeletionagent'
  ## Manages file transfers for iMessage and other IM services.
  'com.apple.imtransferagent'

  ### Intelligence & Proactive (Siri, Spotlight, Suggestions, etc.)
  ## Turns off metadata services entirely (used by Finder, Spotlight, etc.).
  'com.apple.metadata.mds'
  ## Execution service for Siri.
  'com.apple.assistant_service'
  ## The main daemon for Siri.
  'com.apple.assistantd'
  ## Handles Natural Language Understanding tasks for Siri and other internal Apple teams.
  'com.apple.assistant_cdmd'
  ## Coordinates the execution and synchronization of shortcuts from the Shortcuts app.
  #'com.apple.siriactionsd'
  ## The main agent for handling Siri activation and invocation.
  'com.apple.Siri.agent'
  ## Provides inference and suggestions for Siri.
  'com.apple.siriinferenced'
  ## Provides Text-to-Speech (TTS) services for Siri.
  'com.apple.sirittsd'
  ## Manages Siri's knowledge base and conversation context.
  'com.apple.siriknowledged'
  ## Handles the training of Siri's Text-to-Speech models.
  'com.apple.SiriTTSTrainingAgent'
  'com.apple.ContextStoreAgent'
  ## Powers personalized system experiences by learning user habits.
  'com.apple.duetexpertd'
  ## Powers generative AI experiences within the OS.
  'com.apple.generativeexperiencesd'
  ## Manages sessions for on-device intelligence services.
  'com.apple.intelligenceflowd'
  ## Retrieves contextual information from various sources for intelligence services.
  'com.apple.intelligencecontextd'
  ## Analyzes on-device content to build and query a general-purpose knowledge graph.
  'com.apple.intelligenceplatformd'
  ## Provides Siri Suggestions and proactive intelligence.
  'com.apple.knowledge-agent'
  ## Analyzes on-device content to construct a general-purpose knowledge graph.
  'com.apple.knowledgeconstructiond'
  ## Provides natural language processing services, including system-level text editing features.
  'com.apple.naturallanguaged'
  ## Periodically flushes and uploads analytics data for Siri Search.
  'com.apple.parsec-fbf'
  ## The main support daemon for Siri Search and Spotlight suggestions.
  'com.apple.parsecd'
  ## Learns the user's historical location patterns to predict destinations (e.g., for Maps).
  'com.apple.routined'
  ## Processes user content (e.g., emails, messages) to detect contacts, events, and other entities.
  'com.apple.suggestd'

  ### Location & Maps
  ## Manages authorization prompts for applications requesting location access.
  'com.apple.CoreLocationAgent'
  ## A bridge for services using the GeoServices framework.
  'com.apple.geodMachServiceBridge'
  ## Manages push notifications and other services for the Maps application.
  'com.apple.Maps.pushdaemon'
  'com.apple.Maps.mapssyncd'
  'com.apple.maps.destinationd'
  ## Provides "Time to Leave" alerts for calendar events based on location and traffic.
  'com.apple.navd'

  ### Media & Photos
  ## Performs analysis of media files for features like object recognition in photos.
  'com.apple.mediaanalysisd'
  ## Manages the My Photo Stream service.
  'com.apple.mediastream.mstreamd'
  ## Performs on-device analysis of the photo library for memories, people, and scenes.
  'com.apple.photoanalysisd'
  ## The main agent for managing the user's photo library.
  'com.apple.photolibraryd'

  ### MDM (Mobile Device Management)
  ## Handles device enrollment and notifications for managed devices (MDM).
  'com.apple.ManagedClientAgent.enrollagent'

  ### News & Tips
  ## Manages content and notifications for the Apple News application.
  'com.apple.newsd'
  ## Manages and displays tips and suggestions for using macOS.
  'com.apple.tipsd'

  ### QuickLook
  ## Provides the core service for previewing files.
  'com.apple.quicklook'
  ## A helper that manages the user interface for QuickLook previews.
  'com.apple.quicklook.ui.helper'
  ## Generates file thumbnails for Finder and other applications.
  'com.apple.quicklook.ThumbnailsAgent'

  ### Screen Sharing
  ## Agent that facilitates screen sharing access to a user session.
  #'com.apple.screensharing.agent'
  ## Manages the screen sharing menu bar icon and status.
  #'com.apple.screensharing.menuextra'
  ## Allows screen sharing invitations through the Messages app.
  #'com.apple.screensharing.MessagesAgent'
  #'com.apple.SSInvitationAgent'

  ### System Services
  ## Manages audio and video conferencing, including camera access.
  #'com.apple.avconferenced'
  ## A helper process for accessing call history.
  #'com.apple.CallHistoryPluginHelper'
  ## Manages telephony services, including cellular calls and data.
  'com.apple.CommCenter-osx'
  ## Provides speech recognition services to applications.
  'com.apple.corespeechd'
  ## Handles synchronization for calendar and contacts data.
  'com.apple.dataaccess.dataaccessd'
  ## Displays help content in applications.
  'com.apple.helpd'
  ## The system daemon responsible for maintaining the state of phone calls.
  #'com.apple.telephonyutilities.callservicesd'
  ## Powers widgets and their connections to the widget center.
  'com.apple.chronod'
  ## Synchronizes widget data and settings across devices.
  'com.apple.replicatord'
  ## Manages notifications and actions for items that require user follow-up.
  'com.apple.followupd'

  ### Time Machine
  ## A helper agent for Time Machine operations.
  'com.apple.TMHelperAgent'

  ### Trial & Beta
  'com.apple.triald'

  ### TV & Video
  ## Manages video subscriptions and provides analytics for the TV app.
  'com.apple.videosubscriptionsd'
  ## A support daemon for the Apple TV app, managing watchlists and content.
  'com.apple.watchlistd'

  ### Weather
  ## Provides weather data and services for the Weather app and widgets.
  'com.apple.weatherd'

  ## Apple Spell
  'com.apple.applespell'
)
for agent in "${TODISABLE[@]}"; do
  launchctl bootout gui/501/"${agent}" &>/dev/null && echo "Bootout(User): ${agent}" || echo "Failed to bootout(User): ${agent}" # disables the service immediately w/o reboot
  launchctl disable gui/501/"${agent}" # adds the service to the disabled plist, requires reboot
done

## system
TODISABLE=()
TODISABLE+=(
  ### Apple
  ### Analytics & Diagnostics
  ## Collects and submits diagnostic and usage data to Apple.
  'com.apple.analyticsd'
  ## Collects and reports diagnostics and usage data for audio features.
  'com.apple.audioanalyticsd'
  ## Analyzes which frameworks and APIs are used by third-party applications.
  'com.apple.ecosystemanalyticsd'
  ## Collects and reports analytics related to Wi-Fi performance and reliability.
  'com.apple.wifianalyticsd'

  ### Biome
  ## Executes the Biome operation graph, part of a system for user activity prediction.
  'com.apple.biomed'

  ### Continuity & Handoff
  ## Enables Phone Call Handoff, Universal Clipboard, and other continuity features between Apple devices.
  'com.apple.rapportd'

  ### Family Sharing & Screen Time
  ## Handles and persists authorization requests for the Screen Time API as part of Family Controls.
  'com.apple.familycontrols'

  ### Find My
  ## The main process for the "Find My Mac" feature.
  'com.apple.findmymac'
  ## A messenger process for the "Find My Mac" feature.
  'com.apple.findmymacmessenger'
  ## Manages the local "Find My" beaconing for offline finding.
  'com.apple.findmy.findmybeaconingd'
  ## The primary daemon for the "Find My Mac" feature via iCloud.
  'com.apple.icloud.findmydeviced'
  ## The daemon for the "Find My" network's offline finding capabilities.
  'com.apple.icloud.searchpartyd'

  ### Game Controller
  ## Arbitrates access to hardware game controllers for applications.
  'com.apple.GameController.gamecontrollerd'

  ### iCloud
  ## The system daemon that supports the CloudKit framework for cloud data storage.
  'com.apple.cloudd'

  ### Location
  ## Obtains the device's geographic location and manages authorization for apps that request it.
  'com.apple.locationd'

  ### Machine Learning & Proactive
  ## Central daemon for CoreDuet, which tracks user activity for proactive suggestions.
  'com.apple.coreduetd'
  ## Manages machine learning (ML) models and handles requests for their execution.
  'com.apple.modelmanagerd'

  ### MDM (Mobile Device Management)
  ## Assists in installing client Device Enrollment profiles for managed devices (MDM).
  'com.apple.ManagedClient.cloudconfigurationd'

  ### Networking
  ## A stateless DHCPv6 server used by the Internet Sharing service.
  #'com.apple.dhcp6d'
  ## A proxy server for the File Transfer Protocol (FTP).
  'com.apple.ftp-proxy'
  ## Responsible for interacting with NetBIOS networks, typically for Windows file sharing.
  'com.apple.netbiosd'

  ### Screen Sharing
  ## The main daemon that provides screen sharing services.
  #'com.apple.screensharing'

  ### Time Machine
  ## The main daemon for Time Machine backups.
  'com.apple.backupd'
  ## A helper daemon for Time Machine backups.
  'com.apple.backupd-helper'

  ### Trial & Beta
  ### Manages participation in OS and application trials (e.g., betas).
  'com.apple.triald.system'
)
for daemon in "${TODISABLE[@]}"; do
  sudo launchctl bootout system/"${daemon}" &>/dev/null && echo "Bootout(System): ${daemon}" || echo "Failed to bootout(System): ${daemon}" # disables the service immediately w/o reboot
  sudo launchctl disable system/"${daemon}"
done

## User 205 (pre-login)
TODISABLE=()
TODISABLE+=(
  ### Apple
  ### Location
  ## Provides geolocation services to applications and other system processes.
  'com.apple.geod'
)
for agent in "${TODISABLE[@]}"; do
  sudo launchctl bootout user/205/"${agent}" &>/dev/null && echo "Bootout(User205): ${agent}" || echo "Failed to bootout(User205): ${agent}" # disables the service immediately w/o reboot
  sudo launchctl disable user/205/"${agent}"
done