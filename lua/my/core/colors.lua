local default_colors = {
  bg        = "#202328",
  fg        = "#bbc2cf",
  yellow    = "#ECBE7B",
  cyan      = "#008080",
  darkblue  = "#081633",
  green     = "#98be65",
  orange    = "#FF8800",
  violet    = "#a9a1e1",
  magenta   = "#c678dd",
  blue      = "#51afef",
  red       = "#ec5f67"
}

local gruvbox_dark_colors = {
  bg        = "#282828",
  fg        = "#ebdbb2",
  yellow    = "#d79921",
  cyan      = default_colors.cyan,
  darkblue  = default_colors.darkblue,
  green     = "#689d6a",
  orange    = "#d65d0e",
  violet    = default_colors.violet,
  magenta   = "#b16286",
  blue      = "#458588",
  red       = "#cc241d"
}

local one_half_dark_colors = {
  bg        = "#282c34",
  fg        = "#dcdfe4",
  yellow    = "#e5c07b",
  cyan      = "#56b6c2",
  darkblue  = default_colors.darkblue,
  green     = "#98c379",
  orange    = default_colors.orange,
  violet    = default_colors.violet,
  magenta   = "#c678dd",
  blue      = "#61afef",
  red       = "#e06c75"
}

local colorscheme_name = vim.api.nvim_exec(":colorscheme", true)
if colorscheme_name == "gruvbox" then
  return gruvbox_dark_colors
elseif colorscheme_name == "one-nvim" then
  return one_half_dark_colors
else
  return default_colors
end
