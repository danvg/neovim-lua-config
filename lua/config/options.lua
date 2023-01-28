local M = {}

local function disable_builtins()
  local builtin_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
  }

  for _, plugin in ipairs(builtin_plugins) do
    vim.g["loaded_" .. plugin] = 1
  end

  local providers = {
    "python3",
    "ruby",
    "perl",
    "node",
  }

  for _, provider in ipairs(providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
  end
end

local function setup_options()
  -- Global options
  vim.opt.shortmess:append("atI")
  vim.opt.incsearch = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.smarttab = true
  vim.opt.title = true
  vim.opt.backup = false
  vim.opt.writebackup = false
  vim.opt.clipboard:prepend("unnamedplus")
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
  vim.opt.completeopt = "menu,noselect"
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
  vim.opt.wildignore:append("*/node_modules/*,*/__pycache__/*,*.class")
  vim.opt.iskeyword:append("-")

  -- Window options
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.cursorline = true
  vim.opt.colorcolumn = "80"
  vim.opt.spell = false
  vim.opt.wrap = true
  vim.opt.showbreak = "↪"
  vim.opt.linebreak = true
  vim.opt.foldmethod = "marker"
  vim.opt.foldnestmax = 2
  vim.opt.foldcolumn = "1"
  vim.opt.foldlevelstart = 99 -- start with no folds

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
end

M.setup = function()
  disable_builtins()
  setup_options()
end

return M
