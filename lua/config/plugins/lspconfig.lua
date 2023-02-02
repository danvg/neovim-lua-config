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

    mason_lspconfig.setup({
      ensure_installed = {
        "als",
        "clangd",
        "cmake",
        "cssls",
        "html",
        "jdtls",
        "jsonls",
        "sumneko_lua",
        "pyright",
        "tsserver",
        "vimls",
      },
    })

    mason_lspconfig.setup_handlers({
      function(server)
        require("lspconfig")[server].setup({})
      end,
      ["als"] = require("config.plugins.lsp.als"),
      ["clangd"] = require("config.plugins.lsp.clangd"),
      ["jdtls"] = function() end,
      ["sumneko_lua"] = require("config.plugins.lsp.sumneko_lua"),
    })
  end,
}
