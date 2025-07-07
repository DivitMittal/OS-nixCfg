#!/usr/bin/env bash

## Turn Spotlight Off (in case of utilisation of alternate tools, eg. Raycast)
mdutil -a -i off
mdutil -E

## Nvram settings
nvram AutoBoot=%00 # Reset nvram or run this command (  nvram AutoBoot=%03 ) to revert changes made by above command
nvram auto-boot=false
nvram boot-args='-v'

## Unhide
chflags nohidden /Volumes
chflags nohidden ~/Library

## power management
pmset -a displaysleep 10  # Display sleep (in minutes)
pmset -b sleep 15         # Machine sleep (battery) (in minutes)
pmset -c sleep 30         # Machine sleep (charging) (in minutes)
pmset -a lidwake 0        # Wake from sleep when opening lid
pmset -a proximitywake 0  # Wake from sleep when detecting proximity of iCloud devices
pmset -a sms 0            # Disable Sudden Motion Sensors
pmset -a hibernatemode 25 # copy contents of RAM to EEPROM & cut the RAM power
