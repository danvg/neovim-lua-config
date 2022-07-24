local fterm_ok, fterm = pcall(require, "FTerm")
if not fterm_ok then
  vim.notify("FTerm module not found!")
  return
end

fterm.setup({
  cmd = vim.api.nvim_get_option("shell"),
  autoclose = false,
  hl = "Normal",
  blend = 0,
  dimensions = { height = 0.8, width = 0.8, x = 0.5, y = 0.5 }
})

local set_keymap = require("keymap_util").set_keymap
set_keymap("n", "<leader>tt", "<cmd>lua require('FTerm').toggle()<CR>")
set_keymap("t", "<leader>tt",
           "<C-\\><C-n><cmd>lua require('FTerm').toggle()<CR>")
set_keymap("n", "<leader>te", "<cmd>lua require('FTerm').exit()<CR>")
set_keymap("t", "<leader>te", "<C-\\><C-n><cmd>lua require('FTerm').exit()<CR>")
set_keymap("n", "<leader>tg", "<cmd>lua require('FTerm').run('lazygit')<CR>")

vim.cmd [[
  command! FTermOpen lua require("FTerm").open()
  command! FTermClose lua require("FTerm").close()
  command! FTermExit lua require("FTerm").exit()
  command! FTermToggle lua require("FTerm").toggle()
]]
