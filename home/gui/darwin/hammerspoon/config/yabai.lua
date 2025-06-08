local window = require("hs.window")
window.animationDuration = 0

local bind = require("hs.hotkey").bind
local timer = require("hs.timer")

local windowKey = { "alt", "ctrl", "cmd" }
local hyper = { "alt", "ctrl", "cmd", "shift" }

local function execYabai(args)
  local command = string.format("yabai -m %s", args)
  print(string.format("yabai: %s", command))
  hs.execute(command, true)
end

-- Focus spaces
local focus = {
  right = "next",
  left = "prev",
}
local refreshSpaceman = function()
  timer.doAfter(0.2, function()
    hs.execute("cliclick kd:ctrl kp:esc ku:ctrl", true)
  end)
end
for key, direction in pairs(focus) do
  bind(windowKey, key, function()
    execYabai(string.format("space --focus %s", direction))
    refreshSpaceman()
  end)
end

-- Create or destroy spaces
local exist = {
  c = "create",
  d = "destroy",
}
for key, action in pairs(exist) do
  bind(windowKey, key, function()
    execYabai(string.format("space --%s", action))
    refreshSpaceman()
  end)
end

-- Carry windows to next/previous space
bind(windowKey, "tab", function()
  execYabai("window --space next")
end)

bind(hyper, "tab", function()
  execYabai("window --space prev")
end)

-- PiP
bind(windowKey, "p", function()
  execYabai("window --toggle sticky --toggle topmost --toggle pip")
end)

-- Lunches
bind(hyper, "return", function()
  os.execute("open -a wezterm")
  print("Opened Wezterm")
end)