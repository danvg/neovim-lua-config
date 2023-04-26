if vim.fn.has("nvim-0.9") == 1 then
  vim.loader.enable()
end

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

local function bootstrap_plugin_manager()
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_path,
    })
  end

  vim.opt.rtp:prepend(lazy_path)
end

M.setup = function()
  disable_builtins()
  require("config").setup()
  require("lazy").setup("plugins")
end

if _G.CONFIG_BOOTSTRAP == nil or _G.CONFIG_BOOTSTRAP == false then
  bootstrap_plugin_manager()
  M.setup()
  _G.CONFIG_BOOTSTRAP = true
end

return M
