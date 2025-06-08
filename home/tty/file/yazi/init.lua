-- official plugins
require("full-border"):setup()
require("git"):setup()
-- yatline
require("yatline"):setup({
  show_background = false,
  tab_use_inverse = false,
  style_b = { bg = "#393939", fg = "white" },

  display_header_line = true,
  header_line = {
    left = {
      section_a = {
        { type = "line", custom = false, name = "tabs", params = { "left" } },
      },
      section_b = {},
      section_c = {
        { type = "coloreds", custom = false, name = "count", params = "true" },
      },
    },
    right = {
      section_a = {},
      section_b = {},
      section_c = {
        { type = "coloreds", custom = false, name = "task_states" },
      },
    },
  },
  display_status_line = true,
  status_line = {
    left = {
      section_a = {
        { type = "string", custom = false, name = "tab_mode" },
      },
      section_b = {
        { type = "string", custom = false, name = "hovered_path" },
      },
      section_c = {
        { type = "coloreds", custom = false, name = "symlink" },
      },
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "cursor_position" },
      },
      section_b = {
        { type = "string", custom = false, name = "hovered_size" },
      },
      section_c = {
        { type = "string", custom = false, name = "hovered_ownership" },
      },
    },
  },
})
require("yatline-symlink"):setup()