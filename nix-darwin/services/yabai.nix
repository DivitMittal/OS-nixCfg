# #!/usr/bin/env dash
##########################################################################
#                               NOTES                                    #
##########################################################################
####################### Modify the launchctl plist (improved performance)
# plist xml can be found at "yabai --install-service (i.e. ~/Library/LaunchAgents/com.koekeishiya.yabai.plist)"
# Setting dash as the shell for yabai commands.
#
#  <key>EnvironmentVariables</key>
#  <dict>
#    <key>PATH</key>
#    <string>#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
# +  <key>SHELL</key>
# +  <string>/usr/local/bin/dash</string>
#  </dict>

######################## Managed by nix-darwin ############################
####################### Add yabai to sudoers
# sudo visudo -f /private/etc/sudoers.d/yabai
# input the line below into the file you are editing.
#       <user> ALL=(root) NOPASSWD: sha256:<hash> <yabai> --load-sa  # replace <yabai> with the path to the yabai binary (output of: which yabai).
                                                                     # replace <user> with your username (output of: whoami).
                                                                     # replace <hash> with the sha256 hash of the yabai binary (output of: shasum -a 256 $(which yabai)).
                                                                     # this hash must be updated manually after running brew upgrade.

#######################  Loading the scripting addition (SIP must be disabled)
# yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
# sudo yabai --load-sa
##############################################################################

''
  yabai -m rule --add app="^System Settings$" manage=off
  yabai -m rule --add app="^Raycast$" manage=off
  yabai -m rule --add app="^JetBrains Toolbox$" manage=off
  yabai -m rule --add app="^Karabiner-Elements$" manage=off
  yabai -m rule --add app="^Karabiner-EventViewer$" manage=off
  yabai -m rule --add app="^Karabiner-NotificatonWindow$" manage=off

  # Transparent apps
  yabai -m rule --add app="^Code$" opacity=0.97
  yabai -m rule --add app="^IntelliJ IDEA$" opacity=0.97
  yabai -m rule --add app="^CLion$" opacity=0.97
  yabai -m rule --add app="^DataSpell$" opacity=0.97
  yabai -m rule --add app="^DataGrip$" opacity=0.97
  yabai -m rule --add app="^WebStorm$" opacity=0.97
  yabai -m rule --add app="^Notion$" opacity=0.97
  yabai -m rule --add app="^Obsidian$" opacity=0.97
  yabai -m rule --add app="^Finder$" opacity=0.97
  yabai -m rule --add app="^Thunderbird$" opacity=0.97
  yabai -m rule --add app="^Calculator$" sticky=on

  # Kanata daemon (must have a kanata sudoers file)
  sudo $HOME/.local/bin/kanata --cfg /Users/div/Sync-macOS/home/.config/kanata/custom.kbd 1> /dev/null 2> /private/tmp/rs.kanata.err.log
''