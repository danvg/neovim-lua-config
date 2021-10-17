local install_path = vim.fn.stdpath("data") ..
                       "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path
  })
  vim.api.nvim_exec([[packadd packer.nvim]], false)
end

local use = require("packer").use

require("packer").init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
    prompt_border = "single"
  },
  git = {
    clone_timeout = 60 -- Timeout, in seconds, for git clones
  },
  auto_clean = true,
  compile_on_sync = true
})

require("packer").startup(function()
  use({ "wbthomason/packer.nvim" })

  -- Theming

  --[[
  use({
    "npxbr/gruvbox.nvim",
    requires = { "rktjmp/lush.nvim" },
    config = function()
      require("plugins.gruvbox")
    end
  })
  --]]

  use({
    "Mofiqul/vscode.nvim",
    config = function()
      require("plugins.vscode")
    end
  })

  -- LSP, autocomplete, snippets, formatting

  use({
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
    config = function()
      require("plugins.luasnip")
    end
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = { "onsails/lspkind-nvim" },
    after = "LuaSnip",
    config = function()
      require("plugins.cmp")
    end
  })

  use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
  use({ "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" })
  use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

  use({
    "neovim/nvim-lspconfig",
    after = "cmp-nvim-lsp",
    config = function()
      require("plugins.lspconfig")
    end
  })

  use({ "williamboman/nvim-lsp-installer" })

  use({
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = function()
      require("plugins.formatter")
    end
  })

  -- Find, filter and explore

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" }
    },
    config = function()
      require("plugins.telescope")
    end
  })

  -- Highlighting with Treesitter

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = { "p00f/nvim-ts-rainbow" },
    -- run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end
  })

  -- Git integration

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end
  })

  -- File manager

  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.tree")
    end
  })

  -- Markdown support

  use({
    "iamcco/markdown-preview.nvim",
    run = { "cd app && yarn install" },
    cmd = "MarkdownPreview",
    config = function()
      require("plugins.markdown")
    end
  })

  -- Terminal

  use({
    "numToStr/FTerm.nvim",
    config = function()
      require("plugins.fterm")
    end
  })

  -- Statusline & tabline

  use({
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("plugins.lualine")
    end
  })

  use({
    "akinsho/bufferline.nvim",
    requires = { "nvim-web-devicons", opt = true },
    config = function()
      require("plugins.bufferline")
    end
  })

  -- Utility plugins

  use({
    "famiu/bufdelete.nvim",
    config = function()
      local set_keymap = require("utils").set_keymap
      set_keymap("n", "<leader>q",
                 "<cmd>lua require('bufdelete').bufdelete(0, true)<CR>")
    end
  })

  use({
    "b3nj5m1n/kommentary",
    event = "BufRead",
    config = function()
      require("plugins.kommentary")
    end
  })

  use({
    "windwp/nvim-autopairs",
    event = "BufRead",
    config = function()
      require("plugins.autopairs")
    end
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugins.colorizer")
    end
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end
  })

  use({
    "RRethy/vim-illuminate",
    event = "BufRead",
    config = function()
      require("plugins.illuminate")
    end
  })

  use({ "andymass/vim-matchup", opt = true, event = "BufRead" })

  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

end)