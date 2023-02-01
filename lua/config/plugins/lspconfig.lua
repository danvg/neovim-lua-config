return {
  "neovim/nvim-lspconfig",
  requires = {
    { "ray-x/lsp_signature.nvim" },
    { "SmiteshP/nvim-navic" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "mfussenegger/nvim-jdtls" },
  },
  config = function()
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

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup()

    mason_lspconfig.setup_handlers({
      ["als"] = require("config.plugins.lsp.als"),
      ["clangd"] = require("config.plugins.lsp.clangd"),
      ["jdtls"] = function() end,
      ["sumneko_lua"] = require("config.plugins.lsp.sumneko_lua"),
    })
  end,
}
