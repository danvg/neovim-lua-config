vim.g.mkdp_auto_close = 1
vim.g.mkdp_filetypes = { "markdown" }

local set_keymap = require("keymap_util").set_keymap
set_keymap("n", "<C-s>", "<Plug>MarkdownPreview")
set_keymap("n", "<M-s>", "<Plug>MarkdownPreviewStop")
set_keymap("n", "<C-p>", "<Plug>MarkdownPreviewToggle")
