local M = {}

M.on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local function buf_map(mode, lhs, rhs)
    local opts = { silent = true, buffer = bufnr }
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

  vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function()
    vim.lsp.buf.format({ async = true })
  end, {
    bang = true,
  })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.document_formatting = false
M.capabilities.document_range_formatting = false

M.flags = { debounce_text_changes = 150 }

M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = "single",
    }
  ),
}

return M
