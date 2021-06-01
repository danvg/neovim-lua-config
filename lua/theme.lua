-- edge, gruvbox, one-nvim, space-nvim, breezy ...
local theme_name = "nordbuddy"

if theme_name == "gruvbox" then
  -- soft, medium, hard
  vim.g.gruvbox_contrast_dark = "medium"
  vim.g.gruvbox_italic = 1
end

if theme_name == "edge" then
  -- default, aura, neon
  vim.g.edge_style = "default"
  vim.g.edge_enable_italic = 1
end

if theme_name == "breezy" then
  vim.api.nvim_exec([[
    augroup UserHighlights
      autocmd!
      autocmd ColorScheme * hi Normal             ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi LineNr             ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi SignColumn         ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi GitSignsAdd        ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi GitSignsAddNr      ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi GitSignsDelete     ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi GitSignsDeleteNr   ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi GitSignsChange     ctermbg=NONE  guibg=NONE
      autocmd ColorScheme * hi GitSignsChangeNr   ctermbg=NONE  guibg=NONE
    augroup end
  ]], false)
end

vim.opt.background = "dark"

-- Set colorscheme
vim.cmd("colorscheme " .. theme_name)

