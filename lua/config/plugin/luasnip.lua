require("config.lazy").load("friendly-snippets")

require("luasnip").config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").lazy_load()
