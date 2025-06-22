Bind = require("hs.hotkey").bind
TLKeys = {}
TLKeys.window = { "alt", "ctrl", "cmd" }
TLKeys.hyper = { "alt", "ctrl", "shift", "cmd" }

local app = require("hs.application")
local bundleID = {
  wezterm = "com.github.wez.wezterm",
  launchpad = "com.apple.launchpad.launcher",
}
Bind(TLKeys.hyper, "return", nil, function()
  app.launchOrFocusByBundleID(bundleID.wezterm)
end)
Bind(TLKeys.hyper, "l", nil, function()
  app.launchOrFocusByBundleID(bundleID.launchpad)
end)

------
-- Spaces
------
-- require("WindowManager.spaces")
require("WindowManager.yabai")

------
-- Windows
------
require("WindowManager.window")
