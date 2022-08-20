if not packer_plugins["friendly-snippets"].loaded then
  vim.cmd([[packadd friendly-snippets]])
end

require("luasnip").config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()
