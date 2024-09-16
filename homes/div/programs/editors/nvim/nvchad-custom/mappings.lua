require "nvchad.mappings"

local map  = vim.keymap.set
local noremap = { noremap = true, silent = true }
local silent  = { silent  = true }

map('n', '0', '^', noremap)                   -- start of line
map('n', ';', ':', { nowait = true })         -- command mode
map('n', '//','<cmd>nohlsearch <cr>', silent) -- clear search highlighting

-- scroll window up/down even when in insert mode
map('i', '<C-Down>', '<ESC><C-e>', silent)
map('i', '<C-Up>'  , '<ESC><C-y>', silent)
-- to scroll horizontally use <C-h>, <C-l> in normal mode

-- Undo & Redo Fix for Colemak layout
map('n', 'u', "<Nop>", noremap)
map('n', 'U', "<cmd>undo <CR>" , noremap)
map('n', 'R', "<cmd>redo <CR>", noremap)