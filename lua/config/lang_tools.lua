local M = {}

function M.get_mason_cmd(name)
  local bin = vim.fn.stdpath("data") .. "/mason/bin/"
  local cmd = vim.fn.exepath(bin .. name)
  return cmd
end

function M.get_mason_lua_lsp_main()
  local pack = vim.fn.stdpath("data") .. "/mason/packages/lua-language-server"
  return pack .. "/extension/server/main.lua"
end

return M
