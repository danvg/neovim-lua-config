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

local deadlines_path = ""
if vim.loop.os_uname().sysname == "Windows_NT" then
  deadlines_path = vim.fn.expand("D:/School/Current/deadlines.md")
else
  deadlines_path = vim.fn.expand("~/Media/DATA/School/Current/deadlines.md")
end

vim.g.startify_bookmarks = {
  {d = deadlines_path},
  {i = vim.fn.stdpath("config") .. vim.fn.expand("/init.lua")},
  {m = vim.fn.stdpath("config") .. vim.fn.expand("/lua/keymaps.lua")},
  {t = vim.fn.stdpath("config") .. vim.fn.expand("/lua/theme.lua")}
}

vim.g.startify_commands = {{u = {"Update Plugins", ":PackerUpdate"}}}

