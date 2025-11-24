local act = W.action
local split_nav = require("smartSplits")

M.leader = {
  mods = "CTRL",
  key = "r",
  timeout_milliseconds = 800,
}
M.keys = {
  {
    mods = "ALT",
    key = "Enter",
    action = act.DisableDefaultAssignment,
  },
  -- Send ESC+Enter when pressing Shift+Enter
  {
    mods = "SHIFT",
    key = "Enter",
    action = act.SendString("\x1b\r"),
  },
  -- Send Ctrl+r to the terminal when pressing LEADER, LEADER
  {
    mods = "LEADER|CTRL",
    key = "r",
    action = act.SendKey({ mods = "CTRL", key = "r" }),
  },

  -- splitting
  {
    mods = "LEADER",
    key = "s",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },

  {
    mods = "LEADER",
    key = "v",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },

  -- maximize a single pane
  {
    mods = "LEADER",
    key = "5",
    action = act.TogglePaneZoomState,
  },

  -- rotate panes
  {
    mods = "LEADER",
    key = "Space",
    action = act.RotatePanes("Clockwise"),
  },

  -- show the pane selection mode, but have it swap the active and selected panes
  {
    mods = "LEADER",
    key = "f",
    action = act.PaneSelect({ mode = "SwapWithActive" }),
  },

  -- activate copy mode or vim mode
  {
    mods = "LEADER",
    key = "Enter",
    action = act.ActivateCopyMode,
  },

  -- move between split panes
  split_nav("move", "LeftArrow"),
  split_nav("move", "RightArrow"),
  split_nav("move", "UpArrow"),
  split_nav("move", "DownArrow"),

  -- resize split panes
  split_nav("resize", "LeftArrow"),
  split_nav("resize", "RightArrow"),
  split_nav("resize", "UpArrow"),
  split_nav("resize", "DownArrow"),

  -- C-S-l activates the debug overlay (implemented by default)
}

