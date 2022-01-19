local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  vim.notify("lualine module not found!")
  return
end

lualine.setup {
  options = { theme = "dracula-nvim" },
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
  }
}
