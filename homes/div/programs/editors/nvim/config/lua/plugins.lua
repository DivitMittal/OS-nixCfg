local isVSCode = vim.g.vscode -- set by vscode neovim extension

return {
  -- ----------------------------------------------------------- --
  --                   Default Plugins
  -- ----------------------------------------------------------- --
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

  -- create key bindings with help sheets
  {
    "folke/which-key.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    enabled = true,
    cond = not isVSCode,
    cmd = { "ConformInfo" },
    opts = require "configs.conform",
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    keys = {
      { mode = { "n", "v" }, "<leader>fm", function() require("conform").format { async = true } end, desc = "Format buffer", },
    },
  },

  -- git integration, i.e. hunk & blame
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- configure the neovim native LSP server
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    cond = not isVSCode,
    config = function() require("nvchad.configs.lspconfig").defaults() end,
    dependencies = {
      -- LSPs, DAPs, Linters & Formatters Packages Management
      "williamboman/mason.nvim",
      -- automatic setup of lspconfig for Mason installed LSPs
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup()
          require("mason-lspconfig").setup_handlers {
            function(server_name)
              require("lspconfig")[server_name].setup {}
            end,
          }
        end,
      },
    },
  },

  -- completions with snippets, autopairing, etc. with dependencies "windwp/nvim-autopairs", "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" & other snippets
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

  -- fuzzy find/search/view a lot of stuff
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    cond = not isVSCode,
  },

  -- color-text bg & fg colorizer
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
    cond = not isVSCode,
  },

  -- treesitter syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    cond = not isVSCode,
    opts = require "configs.treesitter",
    config = function(_, opts)
      require("nvim-treesitter.install").compilers = { "clang" }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- ----------------------------------------------------------- --
  --                   Custom Plugins
  -- ----------------------------------------------------------- --
  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example

  -- linting
  {
    "mfussenegger/nvim-lint",
    enabled = true,
    cond = not isVSCode,
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    opts = require "configs.lint",
    config = function(_, opts)
      local lint = require('lint')
      lint.linters_by_ft = opts
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        pattern = "*",
        callback = function() lint.try_lint() end,
      })
    end,
  },

  -- Automatically set indentation/tabstop space size of the current buffer
  {
    "nmac427/guess-indent.nvim",
    enabled = true,
    cond = not isVSCode,
    event = "BufEnter",
    opts = {
      auto_cmd = true,
      override_editorconfig = false, -- Set to true to override settings set by .editorconfig

      filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
        "netrw",
        "tutor",
      },
      buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
      on_tab_options = { -- A table of vim options when tabs are detected
        ["expandtab"] = false,
      },
      on_space_options = { -- A table of vim options when spaces are detected
        ["expandtab"] = true,
        ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
        ["softtabstop"] = "detected",
        ["shiftwidth"] = "detected",
      },
    },
  },

  -- Collection of nvim plugins
  {
    "echasnovski/mini.nvim",
    enabled = true,
    event = "BufEnter",
    config = function()
      -- require('mini.jump2d').setup({ labels = 'oienarstwqyxcpl' }) -- EasyMotion/Hop like plugin ( using flash.nvim instead )
      require("mini.align").setup {} -- vim-easy-align like plugin
      require("mini.surround").setup {} -- vim-surround lke plugin

      -- vim-move like plugin
      require("mini.move").setup {
        mappings = {
          -- Move visual selection in Visual mode.
          left = "<M-Left>",
          right = "<M-Right>",
          down = "<M-Down>",
          up = "<M-Up>",
          -- Move current line in Normal mode
          line_left = "<M-Left>",
          line_right = "<M-Right>",
          line_down = "<M-Down>",
          line_up = "<M-Up>",
        },
        options = { reindent_linewise = true },
      }
    end,
  },

  {
    -- vim-vinegar like plugin for filesystem manipulation
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = true,
    cond = not isVSCode,
    event = "VeryLazy",
    cmd = "Oil",
    opts = {},
    keys = {
      { mode = { "n" }, "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
  },

  {
    -- vim-seek/vim-sneak/lightspeed.nvim/mini-jump.nvim/leap.nvim like plugin for multi-charater searching & jumping
    "folke/flash.nvim",
    enabled = true,
    cond = not isVSCode,
    event = "VeryLazy",
    opts = {
      labels = "tsraneiofuplwykdq",
      highlight = { backdrop = false },
      modes = {
        char = {
          enabled = true,
          highlight = { backdrop = false },
        },
        search = { enabled = false },
      },
    },
    keys = {
      { mode = { "n", "x", "o" }, "<cr>", function() require("flash").jump() end, desc = "flash", },
      { mode = { "n", "x", "o" }, "s", function() require("flash").treesitter() end, desc = "flash  treesitter", },
      -- { mode = { "o", "x" }, "r"   , function() require("flash").treesitter_search() end, desc = "treesitter search" },
      -- { mode = { "c" }, "<c-s>", function() require("flash").toggle() end, desc = "toggle flash search" },
      -- { mode = "o"    , "r"    , function() require("flash").remote() end, desc = "Remote Flash" },
    },
  },

  -- multicursors.nvim & hydra.nvim(custom keybinding creation)
  {
    "smoka7/multicursors.nvim",
    dependencies = { "smoka7/hydra.nvim" },
    enabled = true,
    cond = not isVSCode,
    event = "VeryLazy",
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      { mode = { "v", "n" }, "<leader>mc", "<cmd>MCstart<cr>", desc = "selected word under the cursor and listen for actions", },
    },
  },

  -- manoeuvre around splits b/w multiplexers & nvim-splits
  {
    "mrjones2014/smart-splits.nvim",
    enabled = true,
    cond = not isVSCode,
    event = "BufEnter",
    opts = {},
    keys = {
      { mode = { "n" }, "<C-Left>",  function() require("smart-splits").move_cursor_left()  end, desc = "move   cursor left  across splits", },
      { mode = { "n" }, "<C-Right>", function() require("smart-splits").move_cursor_right() end, desc = "move   cursor right across splits", },
      { mode = { "n" }, "<C-Down>",  function() require("smart-splits").move_cursor_down()  end, desc = "move   cursor down  across splits", },
      { mode = { "n" }, "<C-Up>",    function() require("smart-splits").move_cursor_up()    end, desc = "move   cursor up    across splits", },
      { mode = { "n" }, "<A-Up>",    function() require("smart-splits").resize_up()         end, desc = "resize pane   up    across splits", },
      { mode = { "n" }, "<A-Down>",  function() require("smart-splits").resize_down()       end, desc = "resize pane   down  across splits", },
      { mode = { "n" }, "<A-Right>", function() require("smart-splits").resize_right()      end, desc = "resize pane   right across splits", },
      { mode = { "n" }, "<A-Left>",  function() require("smart-splits").resize_left()       end, desc = "resize pane   left  across splits", },
    },
  },
}