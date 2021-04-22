vim.g.mapleader = " "

-- Basics
vim.api.nvim_set_keymap("n", "<leader>q", ":bd<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-w>", ":close<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "jk", "<ESC>", {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv",
                        {noremap = true, silent = true})

-- Better window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", {noremap = true, silent = true})

-- Resize windows
vim.api.nvim_set_keymap("n", "<S-k>", ":resize -4<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-j>", ":resize +4<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-h>", ":vertical resize -4<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-l>", ":vertical resize +4<CR>",
                        {noremap = true, silent = true})

-- Tab key movement
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
