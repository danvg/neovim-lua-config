local bufferline = require("bufferline")
local nnoremap = require("keymap_util").nnoremap

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
    always_show_bufferline = false,
  },
})

nnoremap("<TAB>", "<cmd>BufferLineCycleNext<CR>")
nnoremap("<S-TAB>", "<cmd>BufferLineCyclePrev<CR>")
nnoremap("gb", "<cmd>BufferLinePick<CR>")
