local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  vim.notify("lualine module not found!")
  return
end

local treesitter_ok, treesitter = pcall(require, "nvim-treesitter")
local section_c
if treesitter_ok then
  local function breadcrumbs() return treesitter.statusline() or "" end

  section_c = { "filename", { breadcrumbs } }
else
  section_c = { "filename" }
end

lualine.setup {
  options = { theme = "dracula-nvim" },
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
