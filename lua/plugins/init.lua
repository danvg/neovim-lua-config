local install_path = vim.fn.stdpath("data")
  .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

require("packer").init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
    prompt_border = "single",
  },
  git = {
    clone_timeout = 60, -- Timeout, in seconds, for git clones
  },
  auto_clean = true,
  compile_on_sync = true,
})

require("packer").startup(function()
  local use = require("packer").use

  use({ "wbthomason/packer.nvim" })

  -- Theming

  use({
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup()
    end,
  })

  -- LSP, autocomplete, snippets, formatting, debugging

  use({
    "L3MON4D3/LuaSnip",
    requires = { { "rafamadriz/friendly-snippets", opt = true } },
    event = { "BufRead", "BufNew" },
    config = function()
      require("plugins.luasnip")
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "onsails/lspkind-nvim", opt = true },
    },
    after = "LuaSnip",
    config = function()
      require("plugins.cmp")
    end,
  })

  use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })

  use({
    "neovim/nvim-lspconfig",
    requires = {
      { "williamboman/nvim-lsp-installer", opt = true },
      { "SmiteshP/nvim-navic", opt = true },
      { "ray-x/lsp_signature.nvim", opt = true },
      { "j-hui/fidget.nvim", opt = true },
    },
    after = "cmp-nvim-lsp",
    config = function()
      require("plugins.lspconfig")
    end,
  })

  use({
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = function()
      require("plugins.formatter")
    end,
  })

  use({
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("trouble").setup({})
    end,
  })

  use({
    "mfussenegger/nvim-dap",
    requires = {
      { "rcarriga/nvim-dap-ui", opt = true },
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
    cmd = "DapStart",
    config = function()
      require("plugins.dap")
    end,
  })

  -- Find, filter and explore

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-lua/plenary.nvim", opt = true },
      { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
      { "nvim-telescope/telescope-media-files.nvim", opt = true },
    },
    cmd = "Telescope",
    keys = {
      "<leader>ff",
      "<leader>fn",
      "<leader>fg",
      "<leader>fh",
      "<leader>fc",
      "<leader>fb",
      "<leader>gf",
      "<leader>gc",
      "<leader>gb",
      "<leader>gs",
    },
    config = function()
      require("plugins.telescope")
    end,
  })

  -- Highlighting with Treesitter

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = "p00f/nvim-ts-rainbow",
    config = function()
      require("plugins.treesitter")
    end,
  })

  -- Git integration

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  })

  -- File manager

  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    cmd = { "NvimTreeOpen", "NvimTreeToggle" },
    keys = { "<leader>e" },
    config = function()
      require("plugins.tree")
    end,
  })

  -- Markdown support

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  -- Terminal

  use({
    "numToStr/FTerm.nvim",
    cmd = { "FTermOpen", "FTermToggle" },
    config = function()
      require("plugins.fterm")
    end,
  })

  -- Statusline & tabline

  use({
    "hoob3rt/lualine.nvim",
    requires = {
      { "kyazdani42/nvim-web-devicons" },
      { "SmiteshP/nvim-navic", opt = true },
    },
    config = function()
      require("plugins.lualine")
    end,
  })

  use({
    "akinsho/bufferline.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.bufferline")
    end,
  })

  -- Keybindings

  use({
    "folke/which-key.nvim",
    keys = "<leader>",
    config = function()
      require("which-key").setup({
        spelling = { enabled = true, suggestions = 12 },
      })
    end,
  })

  -- Utility plugins

  use({
    "famiu/bufdelete.nvim",
    config = function()
      vim.keymap.set("n", "<leader>q", function()
        require("bufdelete").bufdelete(0, true)
      end, { silent = true, noremap = true })
    end,
  })

  use({
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNew" },
    config = function()
      require("Comment").setup()
    end,
  })

  use({
    "windwp/nvim-autopairs",
    event = { "BufRead", "BufNew" },
    config = function()
      require("nvim-autopairs").setup()
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNew" },
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        indentLine_enabled = 1,
        char = "▏",
        filetype_exclude = {
          "help",
          "terminal",
          "dashboard",
          "packer",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
        },
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
      })
    end,
  })

  use({
    "RRethy/vim-illuminate",
    event = { "BufRead", "BufNew" },
    setup = function()
      vim.g.Illuminate_ftblacklist = { "NvimTree" }
      vim.g.Illuminate_highlightUnderCursor = 1
      vim.g.Illuminate_delay = 500
    end,
  })

  use({ "andymass/vim-matchup", event = { "BufRead", "BufNew" } })

  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  use({ "editorconfig/editorconfig-vim" })
end)
