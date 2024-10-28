vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

-- lazy.nvim boostrap & plugins
require "configs.lazy"

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- load settings
require "options"
require "autocmds"
vim.schedule(function() require "mappings" end)