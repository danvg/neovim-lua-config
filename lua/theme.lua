-- edge, gruvbox, one-nvim, space-nvim, breezy ...
local theme_name = ""
if vim.loop.os_uname().sysname == "Windows_NT" then
  theme_name = "gruvbox"
else
  theme_name = "nordbuddy"
end

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
  vim.cmd([[
      au FileType * hi Normal       guibg=NONE
      au FileType * hi LineNr       guibg=NONE
      au FileType * hi SignColumn   guibg=NONE
  ]])
end

vim.o.background = "dark"

-- Set colorscheme
vim.cmd("colorscheme " .. theme_name)

