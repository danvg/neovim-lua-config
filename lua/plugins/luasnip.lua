if not packer_plugins["friendly-snippets"] then
  vim.cmd([[packadd friendly-snippets]])
end

local luasnip = require("luasnip")

luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_vscode").load()
