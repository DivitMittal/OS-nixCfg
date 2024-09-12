local isVSCode = vim.g.vscode

return {
  -- ----------------------------------------------------------- --
  --                   Default Plugins
  -- ----------------------------------------------------------- --
  -- configure the neovim native LSP server
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    cond = not isVSCode,
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
      },
    },
  },

  -- package manager for LSP, DAP servers, linters & formatters
  {
    "williamboman/mason.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- treesitter syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    cond = not isVSCode,
    opts = require "configs.treesitter"
  },

  -- library of lua functions
  {
    "nvim-lua/plenary.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- color scheme definition
  {
    "NvChad/base46",
    enabled = true,
    cond = not isVSCode,
  },

  -- color-text bg & fg colorizer
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

  -- icon library for neovim
  {
    "nvim-tree/nvim-web-devicons",
    enabled = true,
    cond = not isVSCode,
  },

  -- indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- git integration, i.e. hunk & blame
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- fuzzy find/search/view a lot of stuff
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

  -- file explorer/navigation
  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    cond = not isVSCode,
    opts = {
      git = {
        enable = true,
      },

      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },

  -- completions with snippets, autopairing, etc.
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    cond = not isVSCode,
    opts = {
      mapping = {
        ["<Up>"] = require("cmp").mapping.select_prev_item(),
        ["<Down>"] = require("cmp").mapping.select_next_item(),
      },
    },
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
      require('guess-indent').setup({ auto_cmd = true, })
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
    end,
  },

  {
    -- vim-vinegar like plugin for filesystem manipulation
    'stevearc/oil.nvim',
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond = not isVSCode,
    event = "VeryLazy",
    cmd = "Oil",
    keys = {
      { mode = {"n"}, "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
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
      { "<cr>", mode = { "n", "x", "o" }, function() require("flash").jump()       end, desc = "flash" },
      { "s",    mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash  treesitter" },
      { "r",    mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "treesitter search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "toggle flash search" },
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
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      { mode = { 'v', 'n' }, '<Leader>mc', '<cmd>MCstart<cr>', desc = 'selected word under the cursor and listen for actions', },
    },
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