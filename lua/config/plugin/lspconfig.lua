require("config.lazy").load({
  "lsp_signature.nvim",
  "nvim-navic",
  "cmp-nvim-lsp",
  "neodev.nvim",
})

require("neodev").setup({})
local lspconfig = require("lspconfig")
local lang_tools = require("config.lang_tools")

local lsp_opts = require("config.lsp_opts")
lsp_opts.capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = lsp_opts.on_attach
lsp_opts.on_attach = function(client, bufnr)
  require("lsp_signature").on_attach()
  require("nvim-navic").attach(client, bufnr)
  on_attach(client, bufnr)
end

local servers = {
  "als",
  "clangd",
  "cmake",
  "cssls",
  "html",
  "jsonls",
  "sumneko_lua",
  "tsserver",
  "vimls",
}

for _, server in ipairs(servers) do
  if server == "als" then
    -- setup Ada language server
    local opts = vim.tbl_extend("force", lsp_opts, {})

    opts.cmd = { lang_tools.get_mason_cmd("ada_language_server") }

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
      print("[als] Using project file: " .. chosen)
      client.notify("workspace/didChangeConfiguration")
      return true
    end

    lspconfig.als.setup(opts)
  elseif server == "clangd" then
    -- setup C/C++ language server
    local opts = vim.tbl_extend("force", lsp_opts, {})

    opts.cmd = {
      lang_tools.get_mason_cmd("clangd"),
      "--enable-config",
      "--background-index",
      "--pch-storage=memory",
      "--all-scopes-completion",
      "--header-insertion=iwyu",
      "--fallback-style=Google",
      "--clang-tidy",
      "--compile-commands-dir=build",
    }

    lspconfig.clangd.setup(opts)
  elseif server == "sumneko_lua" then
    -- setup lua language server
    local opts = vim.tbl_extend("force", lsp_opts, {})
    opts.cmd = {
      lang_tools.get_mason_cmd("lua-language-server"),
      "-E",
      lang_tools.get_mason_lua_lsp_main(),
    }

    opts.settings = {
      Lua = {
        diagnostics = { globals = { "vim", "packer_plugins" } },
        telemetry = { enable = false },
      },
    }

    lspconfig.sumneko_lua.setup(opts)
  else
    lspconfig[server].setup(lsp_opts)
  end
end
