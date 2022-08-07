local M = {}

local default_opts = { silent = true, noremap = true }

M.inoremap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts or default_opts)
end

M.nnoremap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts or default_opts)
end

M.vnoremap = function(lhs, rhs, opts)
  vim.keymap.set("v", lhs, rhs, opts or default_opts)
end

M.tnoremap = function(lhs, rhs, opts)
  vim.keymap.set("t", lhs, rhs, opts or default_opts)
end

return M
