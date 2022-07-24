local M = {}

M.set_keymap = function(mode, left, right, options)
  local use_options = { silent = true, noremap = true }
  if options ~= nil then use_options = options end
  vim.keymap.set(mode, left, right, use_options)
end

return M
