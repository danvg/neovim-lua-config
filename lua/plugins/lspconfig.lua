if not packer_plugins["nvim-lsp-installer"].loaded then
  vim.cmd([[packadd nvim-lsp-installer]])
end

if not packer_plugins["lsp_signature.nvim"].loaded then
  vim.cmd([[packadd lsp_signature.nvim]])
end

if not packer_plugins["nvim-navic"].loaded then
  vim.cmd([[packadd nvim-navic]])
end

if not packer_plugins["fidget.nvim"].loaded then
  vim.cmd([[packadd fidget.nvim]])
end

local lspconfig = require("lspconfig")
local lsp_signature = require("lsp_signature")
local navic = require("nvim-navic")
local fidget = require("fidget")
local lsp_installer = require("nvim-lsp-installer")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local ext = require("plugins.lsp_ext")
local command = vim.api.nvim_create_user_command

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)
  lsp_signature.on_attach()
  navic.attach(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.

  local function buf_map(mode, lhs, rhs)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_map("n", "gD", vim.lsp.buf.declaration)
  buf_map("n", "gd", vim.lsp.buf.definition)
  buf_map("n", "K", vim.lsp.buf.hover)
  buf_map("n", "gi", vim.lsp.buf.implementation)
  buf_map("n", "<C-k>", vim.lsp.buf.signature_help)
  buf_map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
  buf_map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
  buf_map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_foders()))
  end)
  buf_map("n", "<leader>ds", function()
    print(vim.inspect(vim.lsp.buf.document_symbol()))
  end)
  buf_map("n", "<leader>D", vim.lsp.buf.type_definition)
  buf_map("n", "<leader>rn", vim.lsp.buf.rename)
  buf_map("n", "<leader>ca", vim.lsp.buf.code_action)
  buf_map("n", "gr", vim.lsp.buf.references)
  buf_map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end)
end

lsp_installer.setup({
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

fidget.setup({})

local border = {
  { "╔", "FloatBorder" },
  { "═", "FloatBorder" },
  { "╗", "FloatBorder" },
  { "║", "FloatBorder" },
  { "╝", "FloatBorder" },
  { "═", "FloatBorder" },
  { "╚", "FloatBorder" },
  { "║", "FloatBorder" },
}

-- To instead override globally
local open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return open_floating_preview(contents, syntax, opts, ...)
end

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = cmp_nvim_lsp.update_capabilities(base_capabilities)

local lsp_opts = {
  on_attach = custom_on_attach,
  capabilities = cmp_capabilities,
  flags = { debounce_text_changes = 150 },
}

local servers = {
  "als",
  "clangd",
  "cmake",
  "cssls",
  "emmet_ls",
  "html",
  "jdtls",
  "jsonls",
  "sumneko_lua",
  "tsserver",
  "vimls",
}

for _, server in ipairs(servers) do
  if server == "als" then
    -- setup Ada language server
    local opts = vim.tbl_extend("force", lsp_opts, {})

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
      "clangd",
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
    local binary_path = vim.fn.stdpath("data")
      .. "/lsp_servers/sumneko_lua/extension/server/bin"

    local exe_path = binary_path .. "/lua-language-server"
    local main_path = binary_path .. "/main.lua"

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local opts = vim.tbl_extend("force", lsp_opts, {})

    opts.cmd = { exe_path, "-E", main_path }
    opts.settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = runtime_path },
        diagnostics = { globals = { "vim", "packer_plugins" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    }

    lspconfig.sumneko_lua.setup(opts)
  else
    lspconfig[server].setup(lsp_opts)
  end
end

command("LspFormat", function()
  vim.lsp.buf.format({ async = true })
end, { bang = true })
command("LspPeekDeclaration", ext.peek_declaration, { bang = true })
command("LspPeekDefinition", ext.peek_definition, { bang = true })
