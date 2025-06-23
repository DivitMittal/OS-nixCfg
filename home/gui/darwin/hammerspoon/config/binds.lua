Bind = require("hs.hotkey").bind

TLKeys = {}
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

local wifi = require("hs.wifi")
Bind(TLKeys.hyper, "i", nil, function()
  local status = wifi.interfaceDetails().power
  wifi.setPower(not status)
end)

local blueutilOutput, _, _, _ = hs.execute("which blueutil", true)
local blueutilBin = string.gsub(blueutilOutput, "%s+", "")
local function blueutil(args)
  local command = string.format("%s %s", blueutilBin, args)
  print(string.format("blueutil: %s", command))
  local out, _, _, _ = hs.execute(command)
  return out
end
Bind(TLKeys.hyper, "b", nil, function()
  local status = tonumber(blueutil("-p"))
  blueutil(string.format("-p %s", status == 0 and 1 or 0))
end)