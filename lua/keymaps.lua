local function map(mode, lhs, rhs, opts)
  local o = { noremap = true, silent = true }
  if opts ~= nil then o = opts end
  vim.api.nvim_set_keymap(mode, lhs, rhs, o)
end

-- Common keymaps that are not plugin dependent

vim.g.mapleader = " "

-- Basics
map("n", "<leader>q", "<cmd>bd<CR>")
map("i", "jk", "<ESC>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize windows
map("n", "<S-k>", "<cmd>resize -4<CR>")
map("n", "<S-j>", "<cmd>resize +4<CR>")
map("n", "<S-h>", "<cmd>vertical resize -4<CR>")
map("n", "<S-l>", "<cmd>vertical resize +4<CR>")

-- Tab key movement in selection and completion menus
map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

-- Move in insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")

-- Move selected lines in visual mode
map("v", "K", ":move '<-2<CR>gv-gv")
map("v", "J", ":move '>+1<CR>gv-gv")

-- Keymaps that are plugin dependent

-- Confirm completion
map("i", "<CR>", "compe#confirm('<CR>')", { expr = true })

-- Goto definition
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")

-- Preview definition
map("n", "gD", "<cmd>lua require('lspsaga.provider').preview_definition()<CR>")

-- Async lsp finder
map("n", "gr", "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>")

-- Code action
map("n", "<leader>ca",
    "<cmd>lua require('lspsaga.codeaction').code_action()<CR>")

-- Hover doc
map("n", "gh", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")

-- Signature help
map("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")

-- vim.cmd [[ autocmd CursorHoldI * silent! lua require('lspsaga.signaturehelp').signature_help() ]]

-- Rename
map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>")

-- Diagnostics
map("n", "<leader>cd",
    "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>")
map("n", "<leader>cc",
    "<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>")
map("n", "[e",
    "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>")
map("n", "]e",
    "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>")

vim.cmd [[ autocmd CursorHold  * lua require('lspsaga.diagnostic').show_line_diagnostics() ]]

-- Open file manager
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Searching with Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
map("n", "<leader>fc", "<cmd>Telescope colorscheme<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>gf", "<cmd>Telescope git_files<CR>")
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
map("n", "<leader>fa",
    "<cmd>lua require('plugin_config.telescope_utils').search_dotfiles()<CR>")
map("n", "<leader>fn",
    "<cmd>lua require('plugin_config.telescope_utils').search_nvim_config()<CR>")

-- Tabline
map("n", "<TAB>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<CR>")
map("n", "gb", "<cmd>BufferLinePick<CR>")

-- Floaterm
map("n", "<leader>fk", "<cmd>FloatermKill<CR>")
map("n", "<leader>gg", "<cmd>FloatermNew lazygit<CR>")

