require "nvchad.mappings"

local map  = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }
local silent  = { silent  = true }

-- Undo & Redo Fix for Colemak layout
map('n', 'u', "<Nop>", options)
map('n', 'U', "<cmd>undo <CR>" , options)
map('n', 'R', "<cmd>redo <CR>", options)

-- scroll window up/down even when in insert mode
map('i', '<C-Down>', '<ESC><C-e>', silent)
map('i', '<C-Up>'  , '<ESC><C-y>', silent)
-- to scroll horizontally use <C-h>, <C-l> in normal mode

-- start of line
map('n', '0', '^', options)

return {
  general = {
    n = {
      [";"] = { ":", "enter command mode", opts = { nowait = true } },

      ["<leader>tr"] = { function() require("base46").toggle_transparency() end, },

      ["//"] = { "<cmd>nohlsearch <CR>", "clear highlighting search results", opts = silent },
    },
  },
}