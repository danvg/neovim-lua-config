-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(_, bufnr)
  require("lsp_signature").on_attach()

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

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
  -- buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>",
                 opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",
                 opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>dl",
                 "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<leader>dq",
                 "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local custom_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp
                                                                          .protocol
                                                                          .make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = custom_on_attach,
    capabilities = custom_capabilities,
    flags = { debounce_text_changes = 150 }
  }

  -- setup C/C++ language server
  if server.name == "clangd" then
    opts.cmd = {
      "clangd", "--enable-config", "--background-index", "--pch-storage=memory",
      "--all-scopes-completion", "--header-insertion=iwyu",
      "--fallback-style=Google", "--clang-tidy", "--compile-commands-dir=build"
    }
  end

  server:setup(opts)
  vim.api.nvim_exec([[ do User LspAttachBuffers ]], false)
end)

vim.fn.sign_define("LspDiagnosticsSignError",
                   { text = " ", numhl = "LspDiagnosticsDefaultError" })

vim.fn.sign_define("LspDiagnosticsSignInformation", {
  text = " ",
  numhl = "LspDiagnosticsDefaultInformation"
})

vim.fn.sign_define("LspDiagnosticsSignHint",
                   { text = " ", numhl = "LspDiagnosticsDefaultHint" })

vim.fn.sign_define("LspDiagnosticsSignWarning",
                   { text = " ", numhl = "LspDiagnosticsDefaultWarning" })

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false, -- { prefix = "", spacing = 0 },
    signs = true,
    underline = true,
    update_in_insert = false -- update diagnostics insert mode
  })

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

vim.api.nvim_exec([[
  :command! LspDiagnostics :lua vim.lsp.diagnostic.set_loclist()<CR>
  :command! LspFormat :lua vim.lsp.buf.formatting()<CR>
  :command! LspSwitchSourceHeader :lua require("plugins.lsp_ext").switch_source_header()<CR>
  :command! LspPeekDeclaration :lua require("plugins.lsp_ext").peek_declaration()<CR>
  :command! LspPeekDefinition :lua require("plugins.lsp_ext").peek_definition()<CR>

  autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
]], false)
