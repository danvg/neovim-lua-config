local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
  vim.notify("bufferline module not found!")
  return
end

bufferline.setup({
  options = {
    view = "multiwindow",
    indicator_icon = " ",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    close_command = "Bdelete 0",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    separator_style = "thick",
    always_show_bufferline = true
  }
})

local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "gb", "<cmd>BufferLinePick<CR>", opts)
