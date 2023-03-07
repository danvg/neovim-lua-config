local M = {}

M.setup = function()
  -- Leader key
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Kill current buffer
  vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>")

  -- Cycle through buffers
  vim.keymap.set("n", "<TAB>", "<cmd>bnext<CR>")
  vim.keymap.set("n", "<S-TAB>", "<cmd>bprevious<CR>")

  -- Use jk/kj for esc
  vim.keymap.set("i", "jk", "<ESC>")
  vim.keymap.set("i", "kj", "<ESC>")

  -- Better window navigation
  vim.keymap.set("n", "<C-h>", "<C-w>h")
  vim.keymap.set("n", "<C-j>", "<C-w>j")
  vim.keymap.set("n", "<C-k>", "<C-w>k")
  vim.keymap.set("n", "<C-l>", "<C-w>l")

  -- Resize windows
  vim.keymap.set("n", "<C-r>k", "<cmd>resize -4<CR>")
  vim.keymap.set("n", "<C-r>j", "<cmd>resize +4<CR>")
  vim.keymap.set("n", "<C-r>h", "<cmd>vertical resize -4<CR>")
  vim.keymap.set("n", "<C-r>l", "<cmd>vertical resize +4<CR>")

  -- Move in insert mode
  vim.keymap.set("i", "<C-h>", "<Left>")
  vim.keymap.set("i", "<C-j>", "<Down>")
  vim.keymap.set("i", "<C-k>", "<Up>")
  vim.keymap.set("i", "<C-l>", "<Right>")

  -- Move selected lines in visual mode
  vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv")
  vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv")

  -- Move in wrapped lines
  vim.keymap.set({ "n", "v" }, "k", "gk")
  vim.keymap.set({ "n", "v" }, "j", "gj")
  vim.keymap.set({ "n", "v" }, "<Up>", "gk")
  vim.keymap.set({ "n", "v" }, "<Down>", "gj")
  vim.keymap.set("i", "<Up>", "<C-o>gk")
  vim.keymap.set("i", "<Down>", "<C-o>gj")

  -- Diagnostics
  local function show_line_diagnostic()
    vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
  end

  local function show_buf_diagnostic()
    vim.diagnostic.open_float(nil, { focus = false, scope = "buffer" })
  end

  vim.keymap.set("n", "<leader>dl", show_line_diagnostic)
  vim.keymap.set("n", "<leader>db", show_buf_diagnostic)
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist)

  -- Quickfix
  vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>")
  vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>")
  vim.keymap.set("n", "<leader>cp", "<cmd>cprev<cr>")
  vim.keymap.set("n", "<leader>cn", "<cmd>cnext<cr>")

  -- Terminal
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
  vim.keymap.set("t", "jk", [[<C-\><C-n>]])
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
end

return M
