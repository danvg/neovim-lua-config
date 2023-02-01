-- Plugins
local packer_compiled_rtp_path = vim.fn.stdpath("data") .. "/packer"
local packer_compiled_file = packer_compiled_rtp_path .. "/plugin/compiled.lua"
vim.opt.runtimepath:append(packer_compiled_rtp_path)

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
  compile_path = packer_compiled_file,
})

require("packer").startup(function(use)
  local function get_config(plugin_name)
    return require("config.plugins." .. plugin_name)
  end

  -- Let packer manage itself
  use("wbthomason/packer.nvim")

  -- Improve loading times
  use(get_config("impatient"))

  -- Default color scheme
  use(get_config("catppuccin"))

  -- Statusline, tabline, winbar
  use(get_config("lualine"))

  -- Advanced highlighting with treesitter
  use(get_config("treesitter"))

  -- Key discovery
  use(get_config("whichkey"))

  -- Enhanced integrated terminal
  use(get_config("toggleterm"))

  -- Smart buffer deletion
  use(get_config("bufdelete"))

  -- Commenting
  use(get_config("comment"))

  -- Show indentation levels
  use(get_config("indent-blankline"))

  -- Highlight color codes (RGB, hex etc.)
  use(get_config("colorizer"))

  -- Smart parenthesis
  use(get_config("autopairs"))

  -- File explorer
  use(get_config("tree"))

  -- Git support
  use(get_config("gitsigns"))

  -- Search anything
  use(get_config("telescope"))

  -- Completion
  use(get_config("cmp"))

  -- LSP server configurations
  use(get_config("lspconfig"))

  -- Show LSP server progress
  use(get_config("fidget"))

  -- Debugging
  use(get_config("dap"))

  -- Smart diagnostics location window
  use(get_config("trouble"))

  -- Linting and formatting
  use(get_config("null-ls"))

  -- Document symbols
  use(get_config("aerial"))

  -- Startup window
  use(get_config("alpha"))

  -- Session management
  use(get_config("session-manager"))

  -- Enhanced notifications
  use(get_config("notify"))

  -- Project editor configuration
  use(get_config("editorconfig"))

  -- Markdown support
  use(get_config("markdown-preview"))
end)
