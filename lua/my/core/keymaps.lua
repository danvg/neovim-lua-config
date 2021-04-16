local map = require("my.core.functions").map

vim.g.mapleader = " "

-- Basics
map("n", "<leader>q", ":bd<CR>")
map("n", "<C-w>", ":close<CR>")
map("i", "jk", "<ESC>")
map("n", "Q", "<Nop>")
map("n", "ss", ":luafile %<CR>", {silent = false})

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<S-k>", ":resize -4<CR>")
map("n", "<S-j>", ":resize +4<CR>")
map("n", "<S-h>", ":vertical resize -4<CR>")
map("n", "<S-l>", ":vertical resize +4<CR>")

-- Floaterm
map("n", "<leader>fk", ":FloatermKill<CR>")

-- Undotree
map("n", "<leader>u", ":UndotreeToggle<CR>")

-- Git
map("n", "<leader>gg", ":FloatermNew lazygit<CR>")
map("n", "<leader>gf", ":Telescope git_files<CR>")
map("n", "<leader>gc", ":Telescope git_commits<CR>")
map("n", "<leader>gb", ":Telescope git_branches<CR>")
map("n", "<leader>gs", ":Telescope git_status<CR>")

-- buffer navigation
map("n", "<TAB>", ":BufferLineCycleNext<CR>")
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
map("n", "gb", ":BufferLinePick<CR>")

-- File manager
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
map("n", "<leader>t", ":Telescope<CR>")
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fm", ":Telescope media_files<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")
map("n", "<leader>fc", ":Telescope colorscheme<CR>")
map("n", "<leader>fa", ":lua require('my.core.functions').search_dotfiles()<CR>")
map("n", "<leader>fn", ":lua require('my.core.functions').search_nvim()<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")

-- LSP
map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", ":Telescope lsp_definitions<CR>")
map("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
map("n", "gr", ":Telescope lsp_references<CR>")
map("n", "gh", ":lua vim.lsp.buf.hover()<CR>")
map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
map("n", "<space>rn", ":lua vim.lsp.buf.rename()<CR>")
map("n", "<c-p>", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "<c-n>", ":lua vim.lsp.diagnostic.goto_next()<CR>")

-- Markdown preview
map("n", "<leader>mp", ":MarkdownPreview<CR>")
