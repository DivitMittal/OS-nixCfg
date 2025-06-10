local spaces = require("hs.spaces")
local window = require("hs.window")

Drag = hs.loadSpoon("Drag")

-- Wait time for mission control in seconds to perform certain functions
local mcWaitTime = 0.275
spaces.MCwaitTime = mcWaitTime

local function getAllSpaceIDs()
  local spaceIDs = {}
  for _, space in pairs(spaces.allSpaces()) do
    table.insert(spaceIDs, space)
  end
  return spaceIDs[1]
end

local function getCurrentSpaceID()
  local tspace = spaces.activeSpaces()
  for _, space in pairs(tspace) do
    return space
  end
end

-- gets next space id by finding current space id from getCurrentSpaceID & then finding it in getAllSpaceIDs & then returning the next space id
local function getNextSpaceID()
  local currentSpaceID = getCurrentSpaceID()
  local spaceIDs = getAllSpaceIDs()
  for i, spaceID in pairs(spaceIDs) do
    if spaceID == currentSpaceID then
      return spaceIDs[i + 1]
    end
  end
end

local function getPreviousSpaceID()
  local currentSpaceID = getCurrentSpaceID()
  local spaceIDs = getAllSpaceIDs()
  for i, spaceID in pairs(spaceIDs) do
    if spaceID == currentSpaceID then
      return spaceIDs[i - 1]
    end
  end
end

local function goNextSpace()
  local nextSpaceID = getNextSpaceID()
  if nextSpaceID then
    spaces.gotoSpace(nextSpaceID)
  end
end

local function goPrevSpace()
  local previousSpaceID = getPreviousSpaceID()
  if previousSpaceID then
    spaces.gotoSpace(previousSpaceID)
  end
end

local function removeCurrentSpace()
  local toRemoveSpaceID = getCurrentSpaceID()
  goPrevSpace()
  hs.timer.doAfter(mcWaitTime, function()
    spaces.removeSpace(toRemoveSpaceID)
  end)
end

-- Move focused window to the next space
local function moveCurrentWindowToNextSpace()
  local win = window.focusedWindow()
  if not win then
    return
  end
  spaces.moveWindowToSpace(win, getNextSpaceID())
end

-- Move focused window to the previous space
local function moveCurrentWindowToPrevSpace()
  local win = window.focusedWindow()
  if not win then
    return
  end
  spaces.moveWindowToSpace(win, getPreviousSpaceID())
end

local refreshSpaceman = function()
  hs.timer.doAfter(0.2, function()
    print(hs.execute("cliclick kd:ctrl kp:esc ku:ctrl", true))
  end)
end

-- Binds
Bind(TLKeys.window, "right", nil, function()
  goNextSpace()
end)

Bind(TLKeys.window, "left", nil, function()
  goPrevSpace()
end)

Bind(TLKeys.window, "d", nil, function()
  removeCurrentSpace()
  refreshSpaceman()
end)

Bind(TLKeys.window, "c", nil, function()
  spaces.addSpaceToScreen()
  refreshSpaceman()
end)

Bind(TLKeys.window, "tab", nil, function()
  Drag:focusedWindowToSpace(getNextSpaceID())
end)

Bind(TLKeys.hyper, "tab", nil, function()
  Drag:focusedWindowToSpace(getPreviousSpaceID())
end)