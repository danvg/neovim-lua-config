local fterm = require("FTerm")
local nnoremap = require("keymap_util").nnoremap
local tnoremap = require("keymap_util").tnoremap
local command = vim.api.nvim_create_user_command

fterm.setup({
  cmd = vim.api.nvim_get_option("shell"),
  autoclose = false,
  hl = "Normal",
  blend = 0,
  dimensions = { height = 0.8, width = 0.8, x = 0.5, y = 0.5 },
})

nnoremap("<leader>tt", fterm.toggle)
tnoremap("<leader>tt", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<CR>")
nnoremap("<leader>te", fterm.exit)
tnoremap("<leader>te", "<C-\\><C-n><cmd>lua require('FTerm').exit()<CR>")
nnoremap("<leader>tg", function()
  fterm.run("lazygit")
end)

command("FTermOpen", fterm.open, { bang = true })
command("FTermClose", fterm.close, { bang = true })
command("FTermExit", fterm.exit, { bang = true })
command("FTermToggle", fterm.toggle, { bang = true })
