local nnoremap = require("keymap_util").nnoremap
local inoremap = require("keymap_util").inoremap
local vnoremap = require("keymap_util").vnoremap

vim.g.mapleader = " "

-- Kill current buffer
nnoremap("<leader>q", "<cmd>bd<CR>")

-- Cycle through buffers
nnoremap("<TAB>", "<cmd>bnext<CR>")
nnoremap("<S-TAB>", "<cmd>bprevious<CR>")

-- Use jk/kj for esc
inoremap("jk", "<ESC>")
inoremap("kj", "<ESC>")

-- Better window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Resize windows
nnoremap("<C-r>k", "<cmd>resize -4<CR>")
nnoremap("<C-r>j", "<cmd>resize +4<CR>")
nnoremap("<C-r>h", "<cmd>vertical resize -4<CR>")
nnoremap("<C-r>l", "<cmd>vertical resize +4<CR>")

-- Move in insert mode
inoremap("<C-h>", "<Left>")
inoremap("<C-j>", "<Down>")
inoremap("<C-k>", "<Up>")
inoremap("<C-l>", "<Right>")

-- Move selected lines in visual mode
vnoremap("K", ":move '<-2<CR>gv-gv")
vnoremap("J", ":move '>+1<CR>gv-gv")

-- Move in wrapped lines
nnoremap("k", "gk")
vnoremap("k", "gk")
nnoremap("j", "gj")
vnoremap("j", "gj")
nnoremap("<Up>", "gk")
vnoremap("<Up>", "gk")
inoremap("<Up>", "<C-o>gk")
nnoremap("<Down>", "gj")
vnoremap("<Down>", "gj")
inoremap("<Down>", "<C-o>gj")

-- Diagnostics
nnoremap("<leader>dl", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
end)
nnoremap("<leader>db", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "buffer" })
end)
nnoremap("<leader>dn", vim.diagnostic.goto_prev)
nnoremap("<leader>dp", vim.diagnostic.goto_next)
nnoremap("<leader>dq", vim.diagnostic.setloclist)
