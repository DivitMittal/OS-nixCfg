local overrides = require("custom.configs.overrides")
local autocmd   = vim.api.nvim_create_autocmd
local augroup   = vim.api.nvim_create_augroup
local isVSCode  = vim.g.vscode

---@type NvPluginSpec[]
local plugins = {
  -- ----------------------------------------------------------- --
  --                   Default Plugins
  -- ----------------------------------------------------------- --
  -- configure the neovim native LSP server
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    cond = not isVSCode,
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",  -- format & linting
        config = function() require "custom.configs.null-ls" end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- package manager for LSP, DAP servers, linters & formatters
  {
    "williamboman/mason.nvim",
    enabled = true,
    cond = not isVSCode,
    opts = overrides.mason,
  },

  -- treesitter syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    cond = not isVSCode,
    opts = overrides.treesitter,
  },

  -- library of lua functions
  {
    "nvim-lua/plenary.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- programmatic color scheme definition
  {
    "NvChad/base46",
    enabled = true,
    cond = not isVSCode,
  },

  -- programmatic text bg & fg colorizer
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
    cond = not isVSCode,
  },

  -- nvim-nvchad ui library
  {
    "NvChad/ui",
    enabled = true,
    cond = not isVSCode,
  },

  -- nvim terminal plugin
  {
    "NvChad/nvterm",
    enabled = true,
    cond = not isVSCode,
  },

  -- icon library for neovim
  {
    "nvim-tree/nvim-web-devicons",
    enabled = true,
    cond = not isVSCode,
  },

  -- indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    cond = not isVSCode,
  },

  -- git integration, i.e. hunk & blame
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- comment using gc & gcc
  {
    "numToStr/Comment.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- create key bindings with help sheets
  {
    "folke/which-key.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    cond = not isVSCode,
    opts = overrides.nvimtree,
  },

  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    cond = not isVSCode,
    opts = overrides.nvimcmp,
  },

  -- ----------------------------------------------------------- --
  --                   Custom Plugins
  -- ----------------------------------------------------------- --
  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example

  -- Automatically set indentation/tabstop space size of the current buffer
  {
    'nmac427/guess-indent.nvim',
    enabled = true,
    cond = not isVSCode,
    event = "BufEnter",
    config = function()
      require('guess-indent').setup({ auto_cmd = false, })
      autocmd("VimEnter", {
          group = augroup("GuessIndent", { clear = true }),
          command = "autocmd FileType * :silent lua require('guess-indent').set_from_buffer(true)"
      })
    end,
  },

  -- Collection of nvim plugins
  {
    'echasnovski/mini.nvim',
    enabled = true,
    event = "BufEnter",
    config = function ()
      require('mini.align').setup() -- vim-easy-align like plugin
      require('mini.surround').setup()  -- vim-surround lke plugin
      -- require('mini.jump2d').setup({ labels = 'oienarstwqyxcpl' }) -- EasyMotion/Hop like plugin ( using flash.nvim instead )

      -- vim-move like plugin
      require('mini.move').setup({
          mappings = {
            -- Move visual selection in Visual mode.
            left = '<M-Left>', right = '<M-Right>', down = '<M-Down>', up = '<M-Up>',
            -- Move current line in Normal mode
            line_left = '<M-Left>', line_right = '<M-Right>', line_down = '<M-Down>', line_up = '<M-Up>',
          },
          options = { reindent_linewise = true, },
      })

      -- if( not isVSCode ) then
      --   -- nvim starter/dashboard
      --   local starter = require('mini.starter')
      --   starter.setup({
      --   header = 'D!',
      --   footer = '',
      --   content_hooks = {
      --       starter.gen_hook.adding_bullet(),
      --       starter.gen_hook.indexing('all', { 'Builtin actions' }),
      --       starter.gen_hook.padding(3, 2),
      --     },
      --   })
      -- end
    end,
  },

  {
    -- vim-vinegar like plugin for filesystem manipulation
    'stevearc/oil.nvim',
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond = not isVSCode,
    opts = {},
    event = "VeryLazy",
    cmd = "Oil",
    keys = {
      { "-", mode = {"n"}, "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
    config = function() require('oil').setup() end,
  },

  {
    -- vim-seek/vim-sneak/lightspeed.nvim/mini-jump.nvim/leap.nvim like plugin for multi-charater searching & jumping
    "folke/flash.nvim",
    enabled = true,
    cond = not isVSCode,
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump()       end, desc = "Flash" },
      { "S",    mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash  Treesitter" },
      { "R",    mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    },
    config = function()
      require('flash').setup({
        labels = "tsraneiofuplwykdq",
        highlight = { backdrop = false, },
        modes = {
          char = { enabled = true, highlight = { backdrop = false,}, },
          search = { enabled = false, }
        }
      })
    end,
  },

  -- multicursors.nvim & hydra.nvim(custom keybinding creation)
  {
    "smoka7/multicursors.nvim",
    enabled = true,
    cond = not isVSCode,
    event = "VeryLazy",
    dependencies = { 'smoka7/hydra.nvim', },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = { { mode = { 'v', 'n' }, '<Leader>mc', '<cmd>MCstart<cr>', desc = 'selected word under the cursor and listen for actions', }, },
  },

  -- manoeuvre around splits b/w multiplexers & nvim-splits
  {
    'mrjones2014/smart-splits.nvim',
    enabled = true,
    cond = not isVSCode,
    event = "BufEnter",
    keys = {
      { mode  = { 'n' }, "<C-Left>",  '<cmd>lua require("smart-splits").move_cursor_left()  <CR>', desc = "move   cursor left  across splits" },
      { mode  = { 'n' }, "<C-Right>", '<cmd>lua require("smart-splits").move_cursor_right() <CR>', desc = "move   cursor right across splits" },
      { mode  = { 'n' }, "<C-Down>",  '<cmd>lua require("smart-splits").move_cursor_down()  <CR>', desc = "move   cursor down  across splits" },
      { mode  = { 'n' }, "<C-Up>",    '<cmd>lua require("smart-splits").move_cursor_up()    <CR>', desc = "move   cursor up    across splits" },
      { mode  = { 'n' }, "<A-Up>",    '<cmd>lua require("smart-splits").resize_up()         <CR>', desc = "resize pane   up    across splits" },
      { mode  = { 'n' }, "<A-Down>",  '<cmd>lua require("smart-splits").resize_down()       <CR>', desc = "resize pane   down  across splits" },
      { mode  = { 'n' }, "<A-Right>", '<cmd>lua require("smart-splits").resize_right()      <CR>', desc = "resize pane   right across splits" },
      { mode  = { 'n' }, "<A-Left>",  '<cmd>lua require("smart-splits").resize_left()       <CR>', desc = "resize pane   left  across splits" },
    }
  },

  -- syntax highlighting for tridactylrc
  {
    'tridactyl/vim-tridactyl',
    enabled = true,
    cond = not isVSCode,
    event = "VeryLazy"
  },
}

return plugins