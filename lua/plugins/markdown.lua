vim.g.mkdp_auto_close = 1
vim.g.mkdp_filetypes = { "markdown" }

vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>MarkdownPreview",
                        { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<M-s>", "<Plug>MarkdownPreviewStop",
                        { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<Plug>MarkdownPreviewToggle",
                        { silent = true, noremap = true })
