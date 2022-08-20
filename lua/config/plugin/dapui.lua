local dap = require("dap")
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

dapui.setup()

vim.api.nvim_create_user_command("DapUiOpen", dapui.open, { bang = true })
vim.api.nvim_create_user_command("DapUiClose", dapui.close, { bang = true })
vim.api.nvim_create_user_command("DapUiToggle", dapui.toggle, { bang = true })
