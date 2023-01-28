local function setup()
  require("config.options").setup()
  require("config.diagnostics").setup()
  require("config.keymaps").setup()
  require("config.gui").setup()
  require("config.extras").setup()
  require("config.plugins").setup()
end

setup()

-- Auto source config files
local source_init_grp =
  vim.api.nvim_create_augroup("source_init_grp", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = source_init_grp,
  pattern = { "**/nvim/*.lua" },
  callback = function()
    vim.notify("Sourcing init file")
    setup()
  end,
})
