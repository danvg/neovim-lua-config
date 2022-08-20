if not packer_plugins["mason.nvim"].loaded then
  vim.cmd([[packadd mason.nvim]])
end

require("mason-lspconfig").setup({
  ensure_installed = { "lua-language-server" },
})
