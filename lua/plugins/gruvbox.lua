local gruvbox_ok = pcall(require, "gruvbox")
if not gruvbox_ok then
  vim.notify("gruvbox module not found!")
  return;
end

vim.g.gruvbox_contrast_dark = "medium"

vim.cmd [[
  augroup MyHighlights
    autocmd!
    autocmd! ColorScheme * hi clear CursorLine | hi CursorLineNr ctermbg=NONE guibg=NONE | :set cursorline
  augroup end
]]

vim.g.background = "dark"
vim.cmd [[colorscheme gruvbox]]
