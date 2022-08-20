local dap = require("dap")
local lang_tools = require("config.lang_tools")

local function setup_cpp()
  local adapter_exe = lang_tools.get_mason_cmd("OpenDebugAD7")

  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = adapter_exe,
    options = {
      detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input(
          "Path to executable: ",
          vim.fs.normalize(vim.fn.getcwd() .. "/"),
          "file"
        )
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },
  }

  dap.configurations.c = dap.configurations.cpp
end

local function setup()
  setup_cpp()

  vim.keymap.set("n", "F5", dap.continue)
  vim.keymap.set("n", "F10", dap.step_over)
  vim.keymap.set("n", "F11", dap.step_into)
  vim.keymap.set("n", "F12", dap.step_out)
  vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
  vim.keymap.set("n", "<leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end)
  vim.keymap.set("n", "<leader>rp", dap.repl.open)
  vim.keymap.set("n", "<leader>rl", dap.run_last)
end

vim.api.nvim_create_user_command("DapStart", setup, { bang = true })
