-- This colors are used any plugin where colors
-- are configured sush as GalaxyLine etc.

local default_colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  line_bg = "#202328"
}

local gruvbox_dark_colors = {
  bg = "#282828",
  fg = "#ebdbb2",
  yellow = "#d79921",
  cyan = "#458588",
  darkblue = "#458588",
  green = "#689d6a",
  orange = "#d65d0e",
  violet = "#458588",
  magenta = "#b16286",
  blue = "#458588",
  red = "#cc241d",
  line_bg = "#282828"
}

local one_half_dark_colors = {
  bg = "#282c34",
  fg = "#dcdfe4",
  yellow = "#e5c07b",
  cyan = "#56b6c2",
  darkblue = "#61afef",
  green = "#98c379",
  orange = "#e5c07b",
  violet = "#61afef",
  magenta = "#c678dd",
  blue = "#61afef",
  red = "#e06c75",
  line_bg = "#282c34"
}

local nord_dark_colors = {
  bg = "#2E3440",
  fg = "#d8dee9",
  yellow = "#ebcb8b",
  cyan = "#88c0d0",
  darkblue = "#5e81ac",
  green = "#8fbcbb",
  orange = "#d08770",
  violet = "#5e81ac",
  magenta = "#b48ead",
  blue = "#81a1c1",
  red = "#bf616a",
  line_bg = "#2E3440"
}

local colorscheme_name = vim.api.nvim_exec(":colorscheme", true)
if colorscheme_name == "gruvbox" then
  return gruvbox_dark_colors
elseif colorscheme_name == "one-nvim" then
  return one_half_dark_colors
elseif colorscheme_name == "nordbuddy" then
  return nord_dark_colors
else
  return default_colors
end

