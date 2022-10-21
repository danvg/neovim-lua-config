local M = {}

local function lazy_load(name)
  if not packer_plugins[name].loaded then
    vim.cmd("packadd " .. name)
  end
end

M.load = function(names)
  if names == nil then
    return
  end

  if type(names) == "string" then
    lazy_load(names)
  end

  if type(names) == "table" then
    for _, name in ipairs(names) do
      lazy_load(name)
    end
  end
end

return M
