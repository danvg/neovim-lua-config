require("mason").setup({
  ui = {
    border = "single",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

require("config.lazy").load("mason-lspconfig.nvim")
require("mason-lspconfig").setup()
