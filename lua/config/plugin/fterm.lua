local fterm = require("FTerm")

fterm.setup({
  cmd = vim.api.nvim_get_option("shell"),
  autoclose = false,
  hl = "Normal",
  blend = 0,
  dimensions = { height = 0.8, width = 0.8, x = 0.5, y = 0.5 },
})

vim.keymap.set("n", "<leader>tt", fterm.toggle)

vim.keymap.set(
  "t",
  "<leader>tt",
  "<C-\\><C-n><cmd>lua require('FTerm').toggle()<CR>"
)

vim.keymap.set("n", "<leader>te", fterm.exit)

vim.keymap.set(
  "t",
  "<leader>te",
  "<C-\\><C-n><cmd>lua require('FTerm').exit()<CR>"
)
vim.keymap.set("n", "<leader>tg", function()
  fterm.run("lazygit")
end)

vim.api.nvim_create_user_command("FTermOpen", fterm.open, { bang = true })
vim.api.nvim_create_user_command("FTermClose", fterm.close, { bang = true })
vim.api.nvim_create_user_command("FTermExit", fterm.exit, { bang = true })
vim.api.nvim_create_user_command("FTermToggle", fterm.toggle, { bang = true })
