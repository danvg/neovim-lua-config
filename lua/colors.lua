-- This colors are used any plugin where colors
-- are configured sush as GalaxyLine etc.
local default_colors = {
  bg = "#202328",
  bg2 = "#353b45",
  bg3 = "#30243c",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67"
}

local gruvbox_dark_colors = {
  bg = "#282828",
  bg2 = "#3b3e3f",
  bg3 = "#313435",
  fg = "#ebdbb2",
  yellow = "#d79921",
  cyan = "#458588",
  darkblue = "#458588",
  green = "#689d6a",
  orange = "#d65d0e",
  violet = "#458588",
  magenta = "#b16286",
  blue = "#458588",
  red = "#cc241d"
}

local nord_dark_colors = {
  bg = "#2E3440",
  bg2 = "#464c58",
  bg3 = "#494f5b",
  fg = "#d8dee9",
  yellow = "#ebcb8b",
  cyan = "#88c0d0",
  darkblue = "#5e81ac",
  green = "#8fbcbb",
  orange = "#d08770",
  violet = "#5e81ac",
  magenta = "#b48ead",
  blue = "#81a1c1",
  red = "#bf616a"
}

local colorscheme_name = vim.api.nvim_exec(":colorscheme", true)
if colorscheme_name == "gruvbox" then
  return gruvbox_dark_colors
elseif colorscheme_name == "nordbuddy" then
  return nord_dark_colors
else
  return default_colors
end

