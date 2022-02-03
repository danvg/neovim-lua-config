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
  },
  highlights = {
    fill = {
      guifg = { attribute = "fg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "StatusLineNC" }
    },
    background = {
      guifg = { attribute = "fg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "StatusLine" }
    },
    buffer_visible = {
      gui = "",
      guifg = { attribute = "fg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "Normal" }
    },
    buffer_selected = {
      gui = "",
      guifg = { attribute = "fg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "Normal" }
    },
    separator = {
      guifg = { attribute = "bg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "StatusLine" }
    },
    separator_selected = {
      guifg = { attribute = "fg", highlight = "Special" },
      guibg = { attribute = "bg", highlight = "Normal" }
    },
    separator_visible = {
      guifg = { attribute = "fg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "StatusLineNC" }
    },
    close_button = {
      guifg = { attribute = "fg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "StatusLine" }
    },
    close_button_selected = {
      guifg = { attribute = "fg", highlight = "normal" },
      guibg = { attribute = "bg", highlight = "normal" }
    },
    close_button_visible = {
      guifg = { attribute = "fg", highlight = "normal" },
      guibg = { attribute = "bg", highlight = "normal" }
    }
  }
})

local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "gb", "<cmd>BufferLinePick<CR>", opts)
