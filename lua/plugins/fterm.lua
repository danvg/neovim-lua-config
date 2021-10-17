require("FTerm").setup({
  cmd = vim.api.nvim_get_option("shell"),
  autoclose = false,
  hl = "Normal",
  blend = 0,
  dimensions = { height = 0.8, width = 0.8, x = 0.5, y = 0.5 }
})

vim.api.nvim_exec([[
  noremap <silent> <leader>tt :lua require("FTerm").toggle()<CR>
  noremap <silent> <leader>tk :lua require("FTerm").exit()<CR>
  noremap <silent> <leader>tg :lua require("FTerm").run("lazygit")<CR>

  command! FTermOpen lua require("FTerm").open()
  command! FTermClose lua require("FTerm").close()
  command! FTermExit lua require("FTerm").exit()
  command! FTermToggle lua require("FTerm").toggle()
]], false)
