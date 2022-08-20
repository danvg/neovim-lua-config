-- Global options
vim.opt.shortmess:append("atI")
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
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.scrolloff = 10
vim.opt.cmdheight = 1
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
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
vim.opt.wildignore:append("*/node_modules/*,*/__pycache__/*")
vim.opt.iskeyword:append("-")

-- Window options
vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.colorcolumn = nil -- "80"
vim.opt.spell = false
vim.opt.wrap = true
vim.opt.showbreak = "↪"
vim.opt.linebreak = true
vim.opt.foldmethod = "marker"
vim.opt.foldnestmax = 2
vim.opt.foldcolumn = "1"

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.winbar = "%=%m %F"
end

-- Buffer options
local indent = 2
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth = indent
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,latin1"
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"
vim.opt.spelllang = "en,sv"

-- Diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.api.nvim_create_user_command("Diagnostics", function()
  vim.diagnostic.open_float(nil, { focus = false, scope = "buffer" })
end, { bang = true })