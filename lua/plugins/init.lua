local install_path = vim.fn.stdpath("data") ..
                       "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path
  })
  vim.cmd [[packadd packer.nvim]]
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

  --[[ use(
    { "Mofiqul/vscode.nvim", config = function() require("plugins.vscode") end })
 ]]

  use({
    "Mofiqul/dracula.nvim",
    config = function() vim.cmd [[colorscheme dracula]] end
  })

  -- LSP, autocomplete, snippets, formatting

  use({
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
    config = function() require("plugins.luasnip") end
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "onsails/lspkind-nvim", "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline"
    },
    after = "LuaSnip",
    config = function() require("plugins.cmp") end
  })

  use({
    "ray-x/lsp_signature.nvim",
    after = "nvim-cmp",
    config = function()
      require("lsp_signature").setup({ hint_enable = false })
    end
  })

  use({
    "neovim/nvim-lspconfig",
    requires = { "williamboman/nvim-lsp-installer" },
    after = "nvim-cmp",
    config = function() require("plugins.lspconfig") end
  })

  use({ "SmiteshP/nvim-navic", requires = { "nvim-lspconfig" } })

  use({
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = function() require("plugins.formatter") end
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup {} end
  })

  -- Find, filter and explore

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" }
    },
    config = function() require("plugins.telescope") end
  })

  -- Highlighting with Treesitter

  use({
    "nvim-treesitter/nvim-treesitter",
    requires = { "p00f/nvim-ts-rainbow" },
    -- run = ":TSUpdate",
    config = function() require("plugins.treesitter") end
  })

  -- Git integration

  use({
    "lewis6991/gitsigns.nvim",
    config = function() require("plugins.gitsigns") end
  })

  -- File manager

  use({
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function() require("plugins.tree") end
  })

  -- Markdown support

  use({
    "iamcco/markdown-preview.nvim",
    run = { "cd app && yarn install" },
    cmd = "MarkdownPreview",
    config = function() require("plugins.markdown") end
  })

  -- Terminal

  use(
    { "numToStr/FTerm.nvim", config = function() require("plugins.fterm") end })

  -- Statusline & tabline

  use({
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function() require("plugins.lualine") end
  })

  use({
    "akinsho/bufferline.nvim",
    requires = { "nvim-web-devicons", opt = true },
    config = function() require("plugins.bufferline") end
  })

  -- Keybindings

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        spelling = { enabled = true, suggestions = 10 }
      }
    end
  })

  -- Utility plugins

  use({
    "famiu/bufdelete.nvim",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>q",
                              "<cmd>lua require('bufdelete').bufdelete(0, true)<CR>",
                              { silent = true, noremap = true })
    end
  })

  use({
    "b3nj5m1n/kommentary",
    event = { "BufRead", "BufNew" },
    config = function() require("plugins.kommentary") end
  })

  use({
    "windwp/nvim-autopairs",
    event = { "BufRead", "BufNew" },
    config = function() require("plugins.autopairs") end
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNew" },
    config = function() require("plugins.colorizer") end
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("plugins.indent-blankline") end
  })

  use({
    "RRethy/vim-illuminate",
    event = { "BufRead", "BufNew" },
    config = function() require("plugins.illuminate") end
  })

  use({ "andymass/vim-matchup", opt = true, event = { "BufRead", "BufNew" } })

  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  use({ "editorconfig/editorconfig-vim" })

end)
