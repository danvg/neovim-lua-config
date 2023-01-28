local M = {}

M.setup = function()
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })

  vim.api.nvim_create_user_command("Diagnostics", function()
    vim.diagnostic.open_float(nil, { focus = false, scope = "buffer" })
  end, { bang = true })
end

return M
