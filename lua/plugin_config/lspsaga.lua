local saga = require("lspsaga")

local quit_keys = { "q", "<ESC>" }

saga.init_lsp_saga {
  use_saga_diagnostic_sign = true,
  error_sign = "",
  warn_sign = "",
  hint_sign = " ",
  infor_sign = "",
  dianostic_header_icon = "   ",
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 30,
    virtual_text = false
  },
  finder_definition_icon = " ",
  finder_reference_icon = " ",
  max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = quit_keys,
    scroll_down = "<C-n>",
    scroll_up = "<C-p>"
  },
  code_action_keys = { quit = quit_keys, exec = "<CR>" },
  rename_action_keys = { quit = quit_keys, exec = "<CR>" },
  definition_preview_icon = "  ",
  -- "single" "double" "round" "plus"
  border_style = "round",
  rename_prompt_prefix = "➤"
}

