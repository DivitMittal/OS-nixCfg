---@type MappingsTable
local M       = {}

local keymap  = vim.api.nvim_set_keymap
local options = {noremap = true, silent = true}
local silent  = {silent  = true}

-- Undo & Redo Fix for Colemak layout
keymap('n', 'u', "<Nop>", options)
keymap('n', 'U', "<cmd>undo <CR>" , options)
keymap('n', 'R', "<cmd>redo <CR>", options)

-- scroll window up/down even when in insert mode
keymap('i', '<C-Down>', '<ESC><C-e>', silent)
keymap('i', '<C-Up>'  , '<ESC><C-y>', silent)
-- to scroll horizontally use <C-h>, <C-l> in normal mode

-- start of line
keymap('n', '0', '^', options)

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["<leader>tt"] = { function() require("nvterm.terminal").new "float" end, "New float term", opts = silent },

    ["<leader>ht"] = { function() require("nvterm.terminal").new "horizontal" end, "New horizontal term", opts = silent },

    ["<leader>tr"] = { function() require("base46").toggle_transparency() end, },

    ["<leader><CR>"] = { "<cmd>.! <CR>", "Run the last entered text in default configured shell"},

    ["//"] = { "<cmd>nohlsearch <CR>", "clear highlighting search results", opts = silent },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

return M

-- Managed by mini.move plugin
-- Move current-line up or down
-- keymap('v', 'E', ":m '>+1<CR>gv=gv", options)
-- keymap('v', 'U', ":m '<-2<CR>gv=gv", options)
-- Move selected-block left or right & indent it accordingly
-- keymap('v', '<', '<gv', options)
-- keymap('v', '>', '>gv', options)
-- toggle between relative line numbers and absolute line number
-- keymap('n', '<leader>n', ':set relativenumber! <CR>', silent)
-- keymap('n', 'tn', ':tabnew <CR>', options) -- NvChad use <leader>b instead
-- keymap('n', 'tq', ':tabclose <CR>', options) -- NvChad use <leader>x instead
