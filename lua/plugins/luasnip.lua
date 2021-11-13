local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
  vim.notify("luasnip module not found!")
  return
end

luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI"
})

require("luasnip.loaders.from_vscode").load()
