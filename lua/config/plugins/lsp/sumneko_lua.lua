return function()
  local mason_reg_ok, mason_reg = pcall(require, "mason-registry")
  if not mason_reg_ok then
    vim.notify("mason-registry module missing, skipping lsp setup")
    return
  end

  if not mason_reg.has_package("lua-language-server") then
    vim.notify("Missing Mason lua-language-server package, skipping lsp setup")
    return
  end

  local common_opts = require("config.plugins.lsp.options")
  local opts = vim.tbl_extend("force", common_opts, {})

  opts.settings = {
    Lua = {
      diagnostics = { globals = { "vim", "packer_plugins" } },
      telemetry = { enable = false },
      format = { enable = false },
    },
  }

  require("lspconfig").sumneko_lua.setup(opts)
end
