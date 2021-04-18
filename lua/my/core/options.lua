local opt = require("my.core.functions").opt
local cmd = vim.cmd

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
opt("o", "signcolumn", "auto")

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
cmd("set shortmess+=c")
cmd("set iskeyword+=-")
cmd("set path+=$PWD/**")
cmd("filetype plugin on")
