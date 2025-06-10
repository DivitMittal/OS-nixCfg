local VimMode = hs.loadSpoon("VimMode")
local vim = VimMode:new()

vim
  :disableForApp("WezTerm")
  :disableForApp("kitty")
  :disableForApp("iTerm2")
  :disableForApp("Terminal")
  :disableForApp("Code")
  :disableForApp("Obsidian")
vim:shouldDimScreenInNormalMode(false)
vim:shouldShowAlertInNormalMode(true)
vim:setAlertFont(Font.default)
vim:enterWithSequence('tn')