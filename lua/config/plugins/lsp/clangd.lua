return function()
  local mason_reg_ok, mason_reg = pcall(require, "mason-registry")
  if not mason_reg_ok then
    vim.notify("mason-registry module missing, skipping lsp setup")
    return
  end

  if not mason_reg.has_package("clangd") then
    vim.notify("Mason clangd package missing, skipping lsp setup")
    return
  end

  local common_opts = require("config.plugins.lsp.options")
  local opts = vim.tbl_extend("force", common_opts, {})

  opts.cmd = {
    vim.fn.exepath(vim.fn.stdpath("data") .. "/mason/bin/clangd"),
    "--enable-config",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--header-insertion=iwyu",
    "--fallback-style=Google",
    "--clang-tidy",
    "--compile-commands-dir=build",
  }

  require("lspconfig").clangd.setup(opts)
end
