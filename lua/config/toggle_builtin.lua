-- Toggle builtin plugins
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
