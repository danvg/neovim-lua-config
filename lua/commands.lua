function _G.StripTrailingWhitespaces()
  local save = vim.fn.winsaveview()
  vim.api.nvim_exec([[%s/\v\s+$//e]], false)
  vim.fn.winrestview(save)
end

vim.api.nvim_exec([[
  :command! StripTrailingWhitespaces v:lua.StripTrailingWhitespaces()
]], false)
