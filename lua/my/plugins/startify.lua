local custom_header = {
  "", "", "                                       ██            ",
  "                                      ░░             ",
  "    ███████   █████   ██████  ██    ██ ██ ██████████ ",
  "   ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██",
  "    ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██",
  "    ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██",
  "    ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██",
  "   ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░ ",
  "", ""
}

vim.g.webdevicons_enable_startify = 1
vim.g.startify_enable_special = 0
vim.g.startify_session_autoload = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1
vim.g.startify_files_number = 3
-- vim.g.startify_custom_header = custom_header

--[[ -- Custom Header
----------------
local cwd = vim.fn.split(vim.fn.getcwd(), "/")
local banner = vim.fn.system("figlet -f 3d "..cwd[#cwd])
local header = vim.fn["startify#pad"](vim.fn.split(banner, "\n"))
vim.g.startify_custom_header = header ]]

vim.g.startify_lists = {
  -- { type = "dir", header = {"   MRU " .. vim.fn.getcwd()} },
  {type = "bookmarks", header = {"   Bookmarks"}},
  {type = "files", header = {"   Most recent files"}},
  {type = "sessions", header = {"   Sessions"}},
  {type = "commands", header = {"   Commands"}}
}

local funcs = require("my.core.functions")
vim.g.startify_bookmarks = {
  {i = funcs.get_init_filename()},
  {p = funcs.get_plugins_filename()},
  {d = funcs.get_todo_filename()},
  {t = vim.fn.stdpath("config") .. "/lua/my/core/theme.lua"}
}

vim.g.startify_commands = {
  {u = {"Update Plugins", ":PackerUpdate"} }
}
