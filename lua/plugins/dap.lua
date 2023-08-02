return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
  },
  cmd = "SetupDap",
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dapvt = require("nvim-dap-virtual-text")
    local mason_dap = require("mason-nvim-dap")

    local function setup()
      -- setup dapui
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

      vim.api.nvim_create_user_command(
        "DapUiClose",
        dapui.close,
        { bang = true }
      )

      vim.api.nvim_create_user_command(
        "DapUiToggle",
        dapui.toggle,
        { bang = true }
      )

      -- set nvim-dap-virtual-text
      dapvt.setup({})

      -- setup mason-nvim-dap
      mason_dap.setup({
        ensure_installed = { "cpptools", "java-test", "java-debug-adapter" },
        automatic_setup = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
          cppdbg = function(source_name)
            dap.adapters[source_name] = {
              id = "cppdbg",
              type = "executable",
              command = vim.fn.exepath("OpenDebugAD7"),
              options = {
                detached = false,
              },
            }

            dap.configurations.cpp = {
              {
                name = "(gdb) Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                  return vim.fn.input({
                    prompt = "Path to executable: ",
                    default = vim.fs.normalize(vim.fn.getcwd() .. "/"),
                    completion = "file",
                  })
                end,
                args = {},
                stopAtEntry = true,
                cwd = "${workspaceFolder}",
                MIMode = "gdb",
                miDebuggerPath = vim.fn.exepath("gdb"),
              },
            }
          end,
          coreclr = function()
            dap.adapters.netcoredbg = {
              type = "executable",
              command = vim.fn.exepath(
                vim.fn.stdpath("data")
                  .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg"
              ),
              args = { "--interpreter=vscode" },
            }
            dap.configurations.cs = {
              {
                type = "netcoredbg",
                name = "NetCoreDbg: Launch",
                request = "launch",
                cwd = "${fileDirname}",
                program = function()
                  local cwd = vim.fn.getcwd()
                  local d = vim.fn.fnamemodify(cwd, ":t")
                  return vim.fn.input(
                    "Path to dll: ",
                    vim.fs.normalize(cwd .. "/bin/Debug/net6.0/" .. d .. ".dll"),
                    "file"
                  )
                end,
              },
            }
          end,
        },
      })

      -- keymaps
      vim.keymap.set("n", "F5", dap.continue)
      vim.keymap.set("n", "F10", dap.step_over)
      vim.keymap.set("n", "F11", dap.step_into)
      vim.keymap.set("n", "F12", dap.step_out)
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>B", function()
        vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
          dap.set_breakpoint(cond)
        end)
      end)
      vim.keymap.set("n", "<leader>rp", dap.repl.open)
      vim.keymap.set("n", "<leader>rl", dap.run_last)
    end

    vim.api.nvim_create_user_command("SetupDap", setup, { bang = true })
  end,
}
