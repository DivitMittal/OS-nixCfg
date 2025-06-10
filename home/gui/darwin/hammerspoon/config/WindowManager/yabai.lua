local function yabai(args)
  local command = string.format("yabai -m %s", args)
  print(string.format("yabai: %s", command))
  hs.execute(command, true)
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
  hs.timer.doAfter(0.2, function()
    hs.execute("cliclick kd:ctrl kp:esc ku:ctrl", true)
  end)
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