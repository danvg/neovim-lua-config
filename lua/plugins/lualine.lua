local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  vim.notify("lualine module not found!")
  return
end

local breadcrumbs
local navic_ok, navic = pcall(require, "nvim-navic")
if navic_ok then
  breadcrumbs = function()
    if navic.is_available() then
      return navic.get_location({})
    else
      return ""
    end
  end
else
  vim.notify("navic module not found!")
  breadcrumbs = ""
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "github_dimmed",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = { "NvimTree" }, winbar = { "NvimTree " } },
    always_divide_middle = true,
    globalstatus = true,
    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 }
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename" },
    lualine_x = {
      { "diagnostics", sources = { "nvim_diagnostic" } }, "encoding",
      "fileformat", "filetype"
    },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {
    lualine_a = { "filename" },
    lualine_b = { breadcrumbs },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
}
