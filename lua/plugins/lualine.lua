local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  vim.notify("lualine module not found!")
  return
end

local navic_ok, navic = pcall(require, "nvim-navic")

local section_c
if navic_ok then
  local function breadcrumbs()
    if navic.is_available() then return navic.get_location() else return "" end
  end

  section_c = { "filename", { breadcrumbs } }
else
  section_c = { "filename" }
end

lualine.setup {
  options = { theme = "tokyonight" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = section_c,
    lualine_x = {
      { "diagnostics", sources = { "nvim_diagnostic" } }, "encoding",
      "fileformat", "filetype"
    },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  }
}
