vim.g.lf_map_keys = 0
vim.g.lf_replace_netrw = 1

vim.api.nvim_set_keymap("n", "<leader>e", ":Lf<CR>",
                        {noremap = true, silent = true})
