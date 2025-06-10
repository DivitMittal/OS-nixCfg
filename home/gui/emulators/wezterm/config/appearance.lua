-- Tab title string
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

W.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local index = tab.tab_index + 1
  local title = tab.active_pane.title
  local pane = tab.active_pane
  local progress = basename(pane.foreground_process_name)
  local text = index .. ": " .. title .. " [" .. progress .. "]"
  return {
    { Text = text },
  }
end)

---------------------------------------------------------------------------------
M = {
  term = "xterm-256color",
  enable_kitty_graphics = true,

  -- font
  font = W.font("CaskaydiaCove NFM"),
  font_size = 20,
  adjust_window_size_when_changing_font_size = false,
  custom_block_glyphs = false,
  harfbuzz_features = {
    "calt=1",
    "clig=1",
    "liga=1",
  },

  -- appearance
  window_close_confirmation = "NeverPrompt",
  colors = {
    foreground = "silver",
    background = "black",
    --cursor
    cursor_bg = "red",
    cursor_fg = "silver",
    cursor_border = "silver",
  },
  default_cursor_style = "SteadyBar",
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  initial_cols = 100,
  initial_rows = 40,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  native_macos_fullscreen_mode = false,
  window_background_opacity = 0.90,
  window_decorations = "RESIZE",
  enable_scroll_bar = false,

  -- hyperlink
  hyperlink_rules = {
    {
      regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = "mailto:$0",
    },
    {
      regex = [[\bfile://\S*\b]],
      format = "$0",
    },
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = "$0",
    },
    {
      regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
      format = "https://www.github.com/$1/$3",
    },
  },
}