local install_path = vim.fn.stdpath("data") ..
                       "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command(
    "!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.api.nvim_command("packadd packer.nvim")
end

return require("packer").startup(function()
  use {"wbthomason/packer.nvim"}

  -- LSP, Autocomplete and snippets
  use {
    "neovim/nvim-lspconfig", "hrsh7th/nvim-compe", "sbdchd/neoformat",
    "onsails/lspkind-nvim", "glepnir/lspsaga.nvim",
    "hrsh7th/vim-vsnip", "rafamadriz/friendly-snippets"
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope-fzy-native.nvim"},
      {"nvim-telescope/telescope-media-files.nvim"}
    }
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {"windwp/nvim-ts-autotag", "p00f/nvim-ts-rainbow"}
  }

  -- Git
  use {"lewis6991/gitsigns.nvim"}

  -- File manager
  use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}}
  use {"ptzz/lf.vim"}

  -- Markdown
  use {"iamcco/markdown-preview.nvim", run = {"cd app && yarn install"}}

  -- Statusline
  use {"glepnir/galaxyline.nvim"}

  -- Bufferline
  use {
    "akinsho/nvim-bufferline.lua",
    requires = {"kyazdani42/nvim-web-devicons"}
  }

  -- Terminal
  use {"voldikss/vim-floaterm"}

  -- General plugins
  use {
    "mbbill/undotree", "b3nj5m1n/kommentary", "windwp/nvim-autopairs",
    "norcalli/nvim-colorizer.lua", "RRethy/vim-illuminate"
  }

  -- Themes
  use {
    {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}, "sainnhe/edge",
    "Th3Whit3Wolf/one-nvim", "Th3Whit3Wolf/space-nvim", "fneu/breezy",
    {"maaslalani/nordbuddy", requires = {"tjdevries/colorbuddy.nvim"}}
  }

  -- Start screen
  use {"mhinz/vim-startify"}
end)

