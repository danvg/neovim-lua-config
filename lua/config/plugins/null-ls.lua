return {
  "jose-elias-alvarez/null-ls.nvim",
  after = "nvim-lspconfig",
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.clang_format,
        formatting.cmake_format,
        formatting.prettier,
        diagnostics.cpplint,
      },
    })
  end,
}
