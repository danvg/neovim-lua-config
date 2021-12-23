local set_keymap = function(mode, left, right, options)
  local use_options = { silent = true, noremap = true }
  if options ~= nil then use_options = options end
  vim.api.nvim_set_keymap(mode, left, right, use_options)
end

vim.g.mapleader = " "

-- Kill current buffer
set_keymap("n", "<leader>q", "<cmd>bd<CR>")

-- Cycle through buffers
set_keymap("n", "<TAB>", "<cmd>bnext<CR>")
set_keymap("n", "<S-TAB>", "<cmd>bprevious<CR>")

-- Use jk/kj for esc
set_keymap("i", "jk", "<ESC>")
set_keymap("i", "kj", "<ESC>")

-- Better window navigation
set_keymap("n", "<C-h>", "<C-w>h")
set_keymap("n", "<C-j>", "<C-w>j")
set_keymap("n", "<C-k>", "<C-w>k")
set_keymap("n", "<C-l>", "<C-w>l")

-- Resize windows
set_keymap("n", "<C-r>k", "<cmd>resize -4<CR>")
set_keymap("n", "<C-r>j", "<cmd>resize +4<CR>")
set_keymap("n", "<C-r>h", "<cmd>vertical resize -4<CR>")
set_keymap("n", "<C-r>l", "<cmd>vertical resize +4<CR>")

-- Move in insert mode
set_keymap("i", "<C-h>", "<Left>")
set_keymap("i", "<C-j>", "<Down>")
set_keymap("i", "<C-k>", "<Up>")
set_keymap("i", "<C-l>", "<Right>")

-- Move selected lines in visual mode
set_keymap("v", "K", ":move '<-2<CR>gv-gv")
set_keymap("v", "J", ":move '>+1<CR>gv-gv")

-- Move in wrapped lines
set_keymap("n", "k", "gk")
set_keymap("v", "k", "gk")
set_keymap("n", "j", "gj")
set_keymap("v", "j", "gj")
set_keymap("n", "<Up>", "gk")
set_keymap("v", "<Up>", "gk")
set_keymap("i", "<Up>", "<C-o>gk")
set_keymap("n", "<Down>", "gj")
set_keymap("v", "<Down>", "gj")
set_keymap("i", "<Down>", "<C-o>gj")

-- Diagnostics
set_keymap("n", "<leader>dl",
           "<cmd>lua vim.diagnostic.open_float(nil, { focus = false, scope = 'buffer' })<CR>")
set_keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
set_keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_next()<CR>")
set_keymap("n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>")

