vim.g.gruvbox_contrast_dark = "medium"

vim.api.nvim_exec([[
  augroup MyHighlights
    autocmd!
    autocmd! ColorScheme * hi clear CursorLine | hi CursorLineNr ctermbg=NONE guibg=NONE | :set cursorline
  augroup end
]], false)

vim.g.background = "dark"
vim.api.nvim_exec("colorscheme gruvbox", false)
