-- official plugins
require("full-border"):setup()
require("git"):setup()
-- yatline
require("yatline"):setup({
  show_background = false,
  header_line = {
    left = {
      section_a = {
        { type = "string", custom = false, name = "tab_path" },
      },
      section_b = {},
      section_c = {
        { type = "coloreds", custom = false, name = "symlink" },
      },
    },
    right = {
      section_a = {
        { type = "line", custom = false, name = "tabs", params = { "right" } },
      },
      section_b = {},
      section_c = {
        { type = "coloreds", custom = false, name = "count", params = "true" },
      },
    },
  },
  status_line = {
    left = {
      section_a = {
        { type = "string", custom = false, name = "tab_mode" },
      },
      section_b = {
        { type = "string", custom = false, name = "hovered_name" },
      },
      section_c = {
        { type = "coloreds", custom = false, name = "permissions" },
      },
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "cursor_position" },
      },
      section_b = {
        { type = "string", custom = false, name = "cursor_percentage" },
      },
      section_c = {
        { type = "coloreds", custom = false, name = "task_states" },
      },
    },
  },
})
require("yatline-symlink"):setup()