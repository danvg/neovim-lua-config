local functions = {}
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

-- Define autocommands
function functions.define_augroups(definitions)
  -- Create autocommand groups based on the passed definitions
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      vim.cmd(command)
    end

    vim.cmd("augroup END")
  end
end

-- Define options
function functions.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then scopes["o"][key] = value end
end

-- Define mappings
function functions.map(mode, key, result, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, key, result, options)
end

-- Telescope search in the dotfiles directory
function functions.search_dotfiles()
  require("telescope.builtin").find_files(
    {prompt_title = "Dotfiles", cwd = "$HOME/dotfiles/"})
end

-- Telescope search in the nvim config directory
function functions.search_nvim_config()
  require("telescope.builtin").find_files(
    {prompt_title = "Neovim Config", cwd = vim.fn.stdpath("config") .. "/"})
end

return functions
