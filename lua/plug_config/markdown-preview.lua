vim.g.mkdp_auto_close = 1
vim.g.mkdp_filetypes = {'markdown'}

vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>",
                        {noremap = true, silent = true})
