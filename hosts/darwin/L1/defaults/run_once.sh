#! /bin/sh
sudo -v

# Turn Spotlight Off (in case of utilisation of alternate tools, eg. Raycast)
mdutil -a -i off
mdutil -E

# Disable Auto-boot on lid-open and power connection
nvram AutoBoot=%00
# Reset nvram or run this command (  nvram AutoBoot=%03 ) to revert changes made by above command

# Verbose boot
nvram boot-args='-v'

# Unhide
sudo chflags nohidden /Volumes
sudo chflags nohidden ~/Library

# Sleep (in minutes)
sudo pmset -a displaysleep 10 # Display sleep
sudo pmset -b sleep 15        # Machine sleep (battery)
sudo pmset -c sleep 30        # Machine sleep (charging)
# Screensaver (in seconds)
defaults -currentHost write com.apple.screensaver idleTime 300
# Wake from sleep when opening lid; disabled(0)
# pmset lidwake 0