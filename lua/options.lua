-- Global
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.title = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.clipboard:prepend("unnamed,unnamedplus")
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.pumheight = 15
vim.opt.showtabline = 1
vim.opt.updatetime = 400
vim.opt.scrolloff = 10
vim.opt.cmdheight = 1
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.hlsearch = false
vim.opt.signcolumn = "auto"
vim.opt.list = true
vim.opt.listchars = "tab:▸ ,trail:·,precedes:←,extends:→,nbsp:␣"
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.confirm = true
vim.opt.virtualedit = "block"
vim.opt.path:append(".,**")
vim.opt.iskeyword:append("-")

-- Window
vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.conceallevel = 0
vim.opt.spell = false
vim.opt.wrap = true
vim.opt.showbreak = "↪"
vim.opt.linebreak = true
vim.opt.foldmethod = "marker"
vim.opt.foldnestmax = 1
vim.opt.foldcolumn = "1"

-- Buffer
local indent = 2
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth = indent
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.fileencoding = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"
vim.opt.spelllang = "en,sv"

vim.opt.syntax = "on"
vim.api.nvim_exec("filetype plugin indent on", false)
