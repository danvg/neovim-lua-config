-- edge, gruvbox, one-nvim, space-nvim ...
local theme = {name = "gruvbox"}
vim.o.background = "dark"

if theme.name == "gruvbox" then
  -- soft, medium, hard
  vim.g.gruvbox_contrast_dark = "medium"
  vim.g.gruvbox_italic = 1
end

if theme.name == "edge" then
  -- default, aura, neon
  vim.g.edge_style = 'default'
  vim.g.edge_enable_italic = 1
end

-- Set colorscheme
vim.cmd("colorscheme " .. theme.name)

return theme
