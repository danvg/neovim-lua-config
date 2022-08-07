if not packer_plugins["nvim-dap-ui"].loaded then
  vim.cmd([[packadd nvim-dap-ui]])
end

if not packer_plugins["nvim-dap-virtual-text"].loaded then
  vim.cmd([[packadd nvim-dap-virtual-text]])
end

local dap = require("dap")
local dapui = require("dapui")
local dapvt = require("nvim-dap-virtual-text")
local nnoremap = require("keymap_util").nnoremap
local command = vim.api.nvim_create_user_command

local function setup()
  local cpptools_pattern = vim.env.HOME
    .. "/.vscode/extensions/ms-vscode.cpptools*/debugAdapters/bin/OpenDebugAD7"

  if vim.fn.has("win32") then
    cpptools_pattern = cpptools_pattern .. ".exe"
  end

  local cpptools_glob = vim.fn.glob(cpptools_pattern)

  if cpptools_glob ~= nil and #cpptools_glob > 0 then
    local cpptools_exe = vim.fn.expand(cpptools_pattern)

    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = cpptools_exe,
      options = {
        detached = false,
      },
    }

    local gdb_exe = vim.fn.exepath("gdb")

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
      {
        name = "Attach to gdbserver :1234",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = gdb_exe,
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.shellexpand(vim.fn.getcwd() .. "/"),
            "file"
          )
        end,
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end

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
  dapvt.setup({})

  command("DapUiOpen", dapui.open, { bang = true })
  command("DapUiClose", dapui.close, { bang = true })
  command("DapUiToggle", dapui.toggle, { bang = true })

  nnoremap("F5", dap.continue)
  nnoremap("F10", dap.step_over)
  nnoremap("F11", dap.step_into)
  nnoremap("F12", dap.step_out)
  nnoremap("<leader>b", dap.toggle_breakpoint)
  nnoremap("<leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end)
  nnoremap("<leader>rp", dap.repl.open)
  nnoremap("<leader>rl", dap.run_last)
end

command("DapStart", setup, { bang = true })
