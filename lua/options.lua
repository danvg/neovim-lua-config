local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then scopes["o"][key] = value end
end

-- Global
opt("o", "incsearch", true)
opt("o", "ignorecase", true)
opt("o", "smartcase", true)
opt("o", "smarttab", true)
opt("o", "title", true)
opt("o", "backup", false)
opt("o", "writebackup", false)
opt("o", "clipboard", "unnamedplus")
opt("o", "showmode", false)
opt("o", "showcmd", false)
opt("o", "pumheight", 15)
opt("o", "showtabline", 2)
opt("o", "updatetime", 100)
opt("o", "scrolloff", 10)
opt("o", "cmdheight", 1)
opt("o", "termguicolors", true)
opt("o", "mouse", "a")
opt("o", "hidden", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "completeopt", "menuone,noinsert,noselect")
opt("o", "hlsearch", false)
opt("o", "signcolumn", "yes")
opt("o", "list", true)
opt("o", "listchars", "tab:▸ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣")

-- Window
opt("w", "relativenumber", false)
opt("w", "number", true)
opt("w", "numberwidth", 1)
opt("w", "wrap", false)
opt("w", "cursorline", true)
opt("w", "conceallevel", 0)
opt("w", "spell", false)

-- Buffer
local indent = 2
opt("b", "tabstop", indent)
opt("b", "softtabstop", indent)
opt("b", "shiftwidth", indent)
opt("b", "expandtab", true)
opt("b", "autoindent", true)
opt("b", "smartindent", true)
opt("b", "swapfile", false)
opt("b", "undofile", true)
opt("b", "fileencoding", "utf-8")
opt("b", "fileformat", "unix")
opt("b", "spelllang", "en")
opt("b", "syntax", "on")

-- Commands
vim.cmd("set shortmess+=c")
vim.cmd("set iskeyword+=-")
vim.cmd("set path+=$PWD/**")
vim.cmd("filetype plugin on")

