local window = require("hs.window")
window.animationDuration = 0

------
-- Window Paning
------
-- whole
local function maximizeCurrentWindow()
  local win = window.focusedWindow()
  if not win then
    return
  end
  win:maximize()
end

local function centerCurrentWindow()
  local win = window.focusedWindow()
  if not win then
    return
  end
  win:centerOnScreen()
end

-- halves
local function moveCurrentWindowToLeftHalf()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame = hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 2, screenFrame.h)
  win:setFrame(newFrame)
end

local function moveCurrentWindowToRightHalf()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame = hs.geometry.rect(screenFrame.x + screenFrame.w / 2, screenFrame.y, screenFrame.w / 2, screenFrame.h)
  win:setFrame(newFrame)
end

local function moveCurrentWindowToTopHalf()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame = hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w, screenFrame.h / 2)
  win:setFrame(newFrame)
end

local function moveCurrentWindowToBottomHalf()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame = hs.geometry.rect(screenFrame.x, screenFrame.y + screenFrame.h / 2, screenFrame.w, screenFrame.h / 2)
  win:setFrame(newFrame)
end

-- quarters
local function moveCurrentWindowToTopLeft()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame = hs.geometry.rect(screenFrame.x, screenFrame.y, screenFrame.w / 2, screenFrame.h / 2)
  win:setFrame(newFrame)
end

local function moveCurrentWindowToTopRight()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame =
    hs.geometry.rect(screenFrame.x + screenFrame.w / 2, screenFrame.y, screenFrame.w / 2, screenFrame.h / 2)
  win:setFrame(newFrame)
end

local function moveCurrentWindowToBottomLeft()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame =
    hs.geometry.rect(screenFrame.x, screenFrame.y + screenFrame.h / 2, screenFrame.w / 2, screenFrame.h / 2)
  win:setFrame(newFrame)
end

local function moveCurrentWindowToBottomRight()
  local win = window.focusedWindow()
  if not win then
    return
  end
  local screenFrame = win:screen():frame()
  local newFrame = hs.geometry.rect(
    screenFrame.x + screenFrame.w / 2,
    screenFrame.y + screenFrame.h / 2,
    screenFrame.w / 2,
    screenFrame.h / 2
  )
  win:setFrame(newFrame)
end

------
-- Binds
------
Bind(TLKeys.window, "0", nil, centerCurrentWindow)
Bind(TLKeys.window, "1", nil, moveCurrentWindowToBottomLeft)
Bind(TLKeys.window, "2", nil, moveCurrentWindowToBottomHalf)
Bind(TLKeys.window, "3", nil, moveCurrentWindowToBottomRight)
Bind(TLKeys.window, "4", nil, moveCurrentWindowToLeftHalf)
Bind(TLKeys.window, "5", nil, maximizeCurrentWindow)
Bind(TLKeys.window, "6", nil, moveCurrentWindowToRightHalf)
Bind(TLKeys.window, "7", nil, moveCurrentWindowToTopLeft)
Bind(TLKeys.window, "8", nil, moveCurrentWindowToTopHalf)
Bind(TLKeys.window, "9", nil, moveCurrentWindowToTopRight)