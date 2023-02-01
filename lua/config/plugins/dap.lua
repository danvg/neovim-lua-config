return {
  "mfussenegger/nvim-dap",
  requires = {
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
      })

      mason_dap.setup_handlers()

      -- keymaps
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

    vim.api.nvim_create_user_command("SetupDap", setup, { bang = true })
  end,
}
