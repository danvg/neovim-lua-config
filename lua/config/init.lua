local M = {}

M.setup = function()
  require("config.gui").setup()
  require("config.options").setup()
  require("config.diagnostics").setup()
  require("config.keymaps").setup()
  require("config.autocmds").setup()
end

return M
