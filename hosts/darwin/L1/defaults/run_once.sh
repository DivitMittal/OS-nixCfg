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