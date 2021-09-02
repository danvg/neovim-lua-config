local install_path = vim.fn.stdpath "data" ..
                       "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                   install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

require("packer").startup(function()
  use { "wbthomason/packer.nvim" }

  -- LSP, Autocomplete and snippets

  use {
    "neovim/nvim-lspconfig",
    config = function() require("plugin_config.lspconfig") end
  }

  use {
    "hrsh7th/nvim-compe",
    config = function() require("plugin_config.compe") end
  }

  use {
    "onsails/lspkind-nvim",
    config = function() require("plugin_config.lspkind") end
  }

  use {
    "glepnir/lspsaga.nvim",
    config = function() require("plugin_config.lspsaga") end
  }

  use { "hrsh7th/vim-vsnip", requires = { "rafamadriz/friendly-snippets" } }

  use { "sbdchd/neoformat" }

  -- Find, filter and explore

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" }
    },
    config = function() require("plugin_config.telescope") end
  }

  -- Highlighting with Treesitter

  use {
    "nvim-treesitter/nvim-treesitter",
    requires = { "windwp/nvim-ts-autotag", "p00f/nvim-ts-rainbow" },
    run = ":TSUpdate",
    config = function() require("plugin_config.treesitter") end
  }

  -- Git integration

  use {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugin_config.gitsigns") end
  }

  -- File manager

  use {
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function() require("plugin_config.tree") end
  }

  -- Markdown support

  use { "iamcco/markdown-preview.nvim", run = { "cd app && yarn install" } }

  -- Statusline

  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function() require("plugin_config.statusline") end
  }

  -- Bufferline

  use {
    "akinsho/nvim-bufferline.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function() require("plugin_config.bufferline") end
  }

  -- Terminal

  use {
    "voldikss/vim-floaterm",
    config = function() require("plugin_config.floaterm") end
  }

  -- Start screen

  use {
    "mhinz/vim-startify",
    config = function() require("plugin_config.startify") end
  }

  -- Utility plugins

  use {
    "b3nj5m1n/kommentary",
    config = function() require("plugin_config.kommentary") end
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("plugin_config.autopairs") end
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function() require("plugin_config.colorizer") end
  }

  use {
    "RRethy/vim-illuminate",
    config = function() require("plugin_config.illuminate") end
  }

  -- Theming

  use {
    "npxbr/gruvbox.nvim",
    requires = { "rktjmp/lush.nvim" },
    config = function()
      vim.g.gruvbox_contrast_dark = "medium"
      vim.opt.background = "dark"
      vim.api.nvim_exec("colorscheme gruvbox", false)
    end
  }

end)
