return function()
  local mason_reg_ok, mason_reg = pcall(require, "mason-registry")
  if not mason_reg_ok then
    vim.notify("mason-registry module missing, skipping lsp setup")
    return
  end

  if not mason_reg.has_package("ada-language-server") then
    vim.notify("Mason ada-language-server package missing, skipping lsp setup")
    return
  end

  local common_opts = require("config.plugins.lsp.options")
  local opts = vim.tbl_extend("force", common_opts, {})

  opts.cmd = {
    vim.fn.exepath(vim.fn.stdpath("data") .. "/mason/bin/ada_language_server"),
  }

  opts.on_init = function(client)
    local available =
      vim.fn.expand(client.config.root_dir .. "/*.gpr", true, true)
    local chosen

    if available == nil or #available == 0 then
      chosen = nil
    elseif #available == 1 then
      chosen = available[1]
    else
      vim.notify("Selecting a project file...")
      vim.ui.select(
        available,
        { prompt = "Select a project file:" },
        function(choice)
          if choice == nil then
            chosen = available[1]
          else
            chosen = choice
          end
        end
      )
    end

    client.config.settings = { ada = { projectFile = chosen } }
    vim.notify("Using Ada project file: " .. chosen)
    client.notify("workspace/didChangeConfiguration")
    return true
  end

  require("lspconfig").als.setup(opts)
end
