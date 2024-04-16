---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "gatekeeper",
  theme_toggle = { "gatekeeper", "ayu_dark" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  transparency = true,
  nvdash = { load_on_startup = false, },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M