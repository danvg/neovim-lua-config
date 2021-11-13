function _G.StripTrailingWhitespaces()
  local save = vim.fn.winsaveview()
  vim.cmd [[%s/\v\s+$//e]]
  vim.fn.winrestview(save)
end

vim.cmd [[:command! StripTrailingWhitespaces v:lua.StripTrailingWhitespaces()]]
