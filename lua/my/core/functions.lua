local functions = {}

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local api, fn, ft = vim.api, vim.fn, vim.bo.filetype

-- autocommands
function functions.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
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

-- options
function functions.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

-- mappings
function functions.map(mode, key, result, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, key, result, options)
end

-- Telescope
function functions.search_dotfiles()
  require("telescope.builtin").find_files(
  {
    prompt_title = "Dotfiles",
    cwd = "$HOME/dotfiles/"
  }
  )
end

function functions.search_nvim()
  require("telescope.builtin").find_files(
  {
    prompt_title = "Neovim Config",
    cwd = vim.fn.stdpath("config") .. "/"
  }
  )
end

-- Local
--- Check if a file or directory exists in this path
function functions.exists(file)
  if file == "" or file == nil then
    return false
  end
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

function functions.isdir(path)
  if path == "" or path == nil then
    return false
  end
  -- "/" works on both Unix and Windows
  return functions.exists(path .. "/")
end

-- Git
function functions.get_git_root_dir(path)
  -- return parent path for specified entry (either file or directory)
  local function pathname(apath)
    local prefix = ""
    local i = apath:find("[\\/:][^\\/:]*$")
    if i then
      prefix = apath:sub(1, i - 1)
    end

    return prefix
  end

  -- Checks if provided directory contains git directory
  local function has_git_dir(dir)
    local git_dir = dir .. "/.git"
    if functions.isdir(git_dir) then
      return git_dir
    end
  end

  local function has_git_file(dir)
    local gitfile = io.open(dir .. "/.git")
    if not gitfile then
      return false
    end

    local git_dir = gitfile:read():match("gitdir: (.*)")
    gitfile:close()

    return git_dir and dir .. "/" .. git_dir
  end

  -- Set default path to current directory
  if not path or path == "." then
    path = io.popen "cd":read "*l"
  end

  -- Calculate parent path now otherwise we won't be
  -- able to do that inside of logical operator
  local parent_path = pathname(path)

  return has_git_dir(path) or has_git_file(path) or -- Otherwise go up one level and make a recursive call
  (parent_path ~= path and functions.get_git_root_dir(parent_path) or nil)
end

function functions.get_git_branch()
  if ft == "help" then
    return
  end
  local current_file = fn.expand("%:p")
  local current_dir

  -- if file is a symlinks
  if fn.getftype(current_file) == "link" then
    local real_file = fn.resolve(current_file)
    current_dir = fn.fnamemodify(real_file, ":h")
  else
    current_dir = fn.expand("%:p:h")
  end

  local _, gitbranch_pwd = pcall(api.nvim_buf_get_var, 0, "gitbranch_pwd")
  local _, gitbranch_path = pcall(api.nvim_buf_get_var, 0, "gitbranch_path")
  if gitbranch_path and gitbranch_pwd then
    if gitbranch_path:find(current_dir) and string.len(gitbranch_pwd) ~= 0 then
      return gitbranch_pwd
    end
  end
  local git_dir = functions.get_git_root_dir(current_dir)
  if not git_dir then
    return
  end
  local git_root
  if not git_dir:find("/.git") then
    git_root = git_dir
  end
  git_root = git_dir:gsub("/.git", "")

  -- If git directory not found then we're probably outside of repo
  -- or something went wrong. The same is when head_file is nil
  local head_file = git_dir and io.open(git_dir .. "/HEAD")
  if not head_file then
    return
  end

  local HEAD = head_file:read()
  head_file:close()

  -- if HEAD matches branch expression, then we're on named branch
  -- otherwise it is a detached commit
  local branch_name = HEAD:match("ref: refs/heads/(.+)")
  if branch_name == nil then
    return
  end

  api.nvim_buf_set_var(0, "gitbranch_pwd", branch_name)
  api.nvim_buf_set_var(0, "gitbranch_path", git_root)

  return branch_name .. " "
end

function functions.check_workspace()
  local current_file = fn.expand("%:p")
  if current_file == "" or current_file == nil then
    return false
  end
  local current_dir
  -- if file is a symlinks
  if fn.getftype(current_file) == "link" then
    local real_file = fn.resolve(current_file)
    current_dir = fn.fnamemodify(real_file, ":h")
  else
    current_dir = fn.expand("%:p:h")
  end
  local result = functions.get_git_root_dir(current_dir)
  if not result then
    return false
  end
  return true
end

return functions
