-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(_, bufnr)
  local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
  if lsp_signature_ok then lsp_signature.on_attach() end

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

local custom_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
                                        { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                                                { border = "rounded" })
}

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(
                           base_capabilities)

local base_config = {
  on_attach = custom_on_attach,
  capabilities = cmp_capabilities,
  flags = { debounce_text_changes = 150 },
  handlers = custom_handlers
}

local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if lsp_installer_ok then
  lsp_installer.on_server_ready(function(server)
    local opts = vim.tbl_extend("force", base_config, {})

    -- setup C/C++ language server
    if server.name == "clangd" then
      opts.cmd = {
        "clangd", "--enable-config", "--background-index",
        "--pch-storage=memory", "--all-scopes-completion",
        "--header-insertion=iwyu", "--fallback-style=Google", "--clang-tidy",
        "--compile-commands-dir=build"
      }
    end

    -- setup lua language server
    if server.name == "sumneko_lua" then
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      opts.settings = {
        Lua = {
          runtime = { version = "LuaJIT", path = runtime_path },
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false }
        }
      }
    end

    server:setup(opts)
    vim.cmd [[do User LspAttachBuffers]]
  end)
end

-- setup Ada language server
do
  local config = vim.tbl_extend("force", base_config, {
    on_init = function(client)
      local gpr = vim.fn.expand(client.config.root_dir .. "/*.gpr")
      client.config.settings = { ada = { projectFile = gpr } }
      print("[als] Using project file: " .. gpr)
      client.notify("workspace/didChangeConfiguration")
      return true
    end
  })
  require("lspconfig").als.setup(config)
end

vim.cmd [[
  :command! LspFormat :lua vim.lsp.buf.formatting()<CR>
  :command! LspSwitchSourceHeader :lua require("plugins.lsp_ext").switch_source_header()<CR>
  :command! LspPeekDeclaration :lua require("plugins.lsp_ext").peek_declaration()<CR>
  :command! LspPeekDefinition :lua require("plugins.lsp_ext").peek_definition()<CR>
]]
