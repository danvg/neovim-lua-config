local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_ok then
  vim.notify("indent_blankline module not found!")
  return
end

indent_blankline.setup({
  indentLine_enabled = 1,
  char = "▏",
  filetype_exclude = {
    "help", "terminal", "dashboard", "packer", "lspinfo", "TelescopePrompt",
    "TelescopeResults"
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false
})
