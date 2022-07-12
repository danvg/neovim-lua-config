local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then return end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)
  local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
  if lsp_signature_ok then lsp_signature.on_attach() end

  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok then navic.attach(client, bufnr) end

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>wa",
                 "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wr",
                 "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wl",
                 "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                 opts)
  buf_set_keymap("n", "<leader>ds",
                 "<cmd>lua print(vim.inspect(vim.lsp.buf.document_symbol()))<CR>",
                 opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>",
                 opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",
                 opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local border = {
  { "╔", "FloatBorder" }, { "═", "FloatBorder" }, { "╗", "FloatBorder" },
  { "║", "FloatBorder" }, { "╝", "FloatBorder" }, { "═", "FloatBorder" },
  { "╚", "FloatBorder" }, { "║", "FloatBorder" }
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(
                           base_capabilities)

local base_settings = {
  on_attach = custom_on_attach,
  capabilities = cmp_capabilities,
  flags = { debounce_text_changes = 150 }
}

local servers = {
  "als", "clangd", "cmake", "cssls", "emmet_ls", "html", "jdtls", "jsonls",
  "sumneko_lua", "tsserver"
}

for _, server in ipairs(servers) do
  if server == "als" then
    -- setup Ada language server
    local settings = vim.tbl_extend("force", base_settings, {})

    settings.on_init = function(client)
      local gpr = vim.fn.expand(client.config.root_dir .. "/*.gpr")
      client.config.settings = { ada = { projectFile = gpr } }
      print("[als] Using project file: " .. gpr)
      client.notify("workspace/didChangeConfiguration")
      return true
    end

    lspconfig.als.setup(settings)
  elseif server == "clangd" then
    -- setup C/C++ language server
    local settings = vim.tbl_extend("force", base_settings, {})

    settings.cmd = {
      "clangd", "--enable-config", "--background-index", "--pch-storage=memory",
      "--all-scopes-completion", "--header-insertion=iwyu",
      "--fallback-style=Google", "--clang-tidy", "--compile-commands-dir=build"
    }

    lspconfig.clangd.setup(settings)
  elseif server == "sumneko_lua" then
    -- setup lua language server
    local binary_path = vim.fn.stdpath("data") ..
                          "/lsp_servers/sumneko_lua/extension/server/bin"

    local exe_path = binary_path .. "/lua-language-server"
    local main_path = binary_path .. "/main.lua"

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local settings = vim.tbl_extend("force", base_settings, {})

    settings.cmd = { exe_path, "-E", main_path }
    settings.settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = runtime_path },
        diagnostics = { globals = { "vim" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false }
      }
    }

    lspconfig.sumneko_lua.setup(settings)
  else
    lspconfig[server].setup(base_settings)
  end
end

local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if lsp_installer_ok then
  lsp_installer.setup({
    automatic_installation = true,
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    }
  })
end

vim.cmd [[
  :command! LspFormat :lua vim.lsp.buf.formatting()<CR>
  :command! LspSwitchSourceHeader :lua require("plugins.lsp_ext").switch_source_header()<CR>
  :command! LspPeekDeclaration :lua require("plugins.lsp_ext").peek_declaration()<CR>
  :command! LspPeekDefinition :lua require("plugins.lsp_ext").peek_definition()<CR>
]]
