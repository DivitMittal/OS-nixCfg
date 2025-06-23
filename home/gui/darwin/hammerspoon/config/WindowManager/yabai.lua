local yabaiOutput, _, _, _ = hs.execute("which yabai", true)
local yabaiBin = string.gsub(yabaiOutput, "%s+", "")
local function yabai(args)
  local command = string.format("%s -m %s", yabaiBin, args)
  print(string.format("yabai: %s", command))
  os.execute(command)
end

-- Focus spaces
local focus = { right = "next", left = "prev" }
for key, direction in pairs(focus) do
  Bind(TLKeys.window, key, nil, function()
    yabai(string.format("space --focus %s", direction))
  end)
end

-- Create or destroy spaces
local refreshSpaceman = function()
  hs.eventtap.keyStroke({ "ctrl" }, "escape", 0.2)
end
local exist = { c = "create", d = "destroy" }
for key, action in pairs(exist) do
  Bind(TLKeys.window, key, nil, function()
    yabai(string.format("space --%s", action))
    refreshSpaceman()
  end)
end

-- Carry windows to next/previous space
Bind(TLKeys.window, "tab", nil, function()
  yabai("window --space next")
end)

Bind(TLKeys.hyper, "tab", nil, function()
  yabai("window --space prev")
end)

-- PiP
Bind(TLKeys.window, "p", nil, function()
  yabai("window --toggle sticky --toggle topmost --toggle pip")
end)