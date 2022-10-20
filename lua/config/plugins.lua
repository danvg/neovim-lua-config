local packer_install_path = vim.fn.stdpath("data")
  .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    packer_install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

require("packer").init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})

require("packer").startup(function(use)
  local function get_config(name)
    return string.format([[require("config.plugin.%s")]], name)
  end

  -- Let packer manage itself
  use("wbthomason/packer.nvim")

  -- Default theme
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = get_config("catppuccin"),
  })

  -- Statusline, tabline, winbar
  use({
    "hoob3rt/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      { "SmiteshP/nvim-navic", opt = true },
    },
    event = { "BufRead", "BufNew" },
    config = get_config("lualine"),
  })

  -- Advanced highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufEnter" },
    config = get_config("treesitter"),
  })

  use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

  -- Smart buffer deletion
  use({
    "famiu/bufdelete.nvim",
    event = { "BufRead", "BufEnter" },
    config = get_config("bufdelete"),
  })

  -- Comments
  use({
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufEnter" },
    config = get_config("comment"),
  })

  -- Highlight scopes
  use({ "andymass/vim-matchup", event = { "BufRead", "BufEnter" } })

  -- Show indentation levels
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNew" },
    config = get_config("indent_blankline"),
  })

  -- Show the color of color codes (RGB, hex etc.)
  use({
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufEnter" },
    config = get_config("colorizer"),
  })

  -- Close parenthesis
  use({
    "windwp/nvim-autopairs",
    event = { "BufRead", "BufEnter" },
    config = get_config("autopairs"),
  })

  -- Measure startup time
  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  use({ "editorconfig/editorconfig-vim", event = { "BufRead", "BufEnter" } })

  -- Key discovery
  use({
    "folke/which-key.nvim",
    keys = "<leader>",
    config = get_config("which-key"),
  })

  -- Floating terminal
  use({
    "numToStr/FTerm.nvim",
    cmd = "FTermToggle",
    config = get_config("fterm"),
  })

  -- Explorer panel
  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    cmd = "NvimTreeToggle",
    keys = "<leader>e",
    config = get_config("tree"),
  })

  -- Git support
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    event = { "BufRead", "BufNew" },
    config = get_config("gitsigns"),
  })

  -- Search anything
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim", opt = true },
      { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
    },
    cmd = "Telescope",
    keys = { "<leader>ff", "<leader>fg", "<leader>fn" },
    config = get_config("telescope"),
  })

  -- Snippets
  use({
    "L3MON4D3/LuaSnip",
    requires = { { "rafamadriz/friendly-snippets", opt = true } },
    event = "InsertEnter",
    config = get_config("luasnip"),
  })

  -- Completion engine
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    requires = { { "onsails/lspkind-nvim", opt = true } },
    after = "LuaSnip",
    config = get_config("cmp"),
  })

  use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
  use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })

  -- LSP configuration
  use({
    "neovim/nvim-lspconfig",
    ft = {
      "ada",
      "c",
      "cpp",
      "cmake",
      "css",
      "html",
      "javascript",
      "typescript",
      "json",
      "java",
      "vim",
      "lua",
    },
    requires = {
      { "ray-x/lsp_signature.nvim", opt = true },
      { "folke/neodev.nvim", opt = true },
      { "SmiteshP/nvim-navic", opt = true },
    },
    config = get_config("lspconfig"),
  })

  use({ "mfussenegger/nvim-jdtls", opt = true })

  -- Installer of LSP servers, formatters, linters etc.
  use({
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = get_config("mason"),
  })

  -- LSP integration
  use({
    "williamboman/mason-lspconfig.nvim",
    after = "nvim-lspconfig",
    config = get_config("mason-lspconfig"),
  })

  -- Show LSP server status
  use({
    "j-hui/fidget.nvim",
    after = "nvim-lspconfig",
    config = get_config("fidget"),
  })

  -- Smart diagnostics
  use({
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = get_config("trouble"),
  })

  -- Language aware formatter
  use({
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = get_config("formatter"),
  })

  -- Debugging
  use({
    "mfussenegger/nvim-dap",
    cmd = "DapStart",
    config = get_config("dap"),
  })

  use({
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = get_config("dapui"),
  })

  use({
    "theHamsta/nvim-dap-virtual-text",
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup({})
    end,
  })
end)
