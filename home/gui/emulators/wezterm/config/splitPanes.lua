-- Pane navigation and resizing b/w wezterm & vim/nvim (smart-splits.nvim plugin required)
local function is_vim(pane)
  -- this is set by the smart-splits.nvim plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_from_key = {
  LeftArrow = "Left",
  RightArrow = "Right",
  UpArrow = "Up",
  DownArrow = "Down",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "move" and "CTRL" or "ALT",

    action = W.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = {
            key = key,
            mods = resize_or_move == "resize" and "ALT" or "CTRL",
          },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({
            AdjustPaneSize = { direction_from_key[key], 3 },
          }, pane)
        else
          win:perform_action({
            ActivatePaneDirection = direction_from_key[key],
          }, pane)
        end
      end
    end),
  }
end

-- Binds
M.keys = {
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
}