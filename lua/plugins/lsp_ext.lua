local M = {}

M.switch_source_header = function()
  vim.lsp.buf_request(0, "textDocument/switchSourceHeader",
                      vim.lsp.util.make_text_document_params(),
                      function(err, result, ctx, config)
    if err then
      error(err)
    else
      vim.api.nvim_exec("e " .. vim.uri_to_fname(result), false)
    end
  end)
end

M.preview_location = function(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 15
  before_context = before_context or 0
  local uri = location.targetUri or location.uri
  if uri == nil then return end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then vim.fn.bufload(bufnr) end
  local range = location.targetRange or location.range
  local contents = vim.api.nvim_buf_get_lines(bufnr, range.start.line -
                                                before_context,
                                              range["end"].line + 1 + context,
                                              false)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return vim.lsp.util.open_floating_preview(contents, filetype)
end

M.preview_location_callback = function(err, result, ctx, config)
  local context = 15
  if err then
    error(err)
  else
    if result == nil or vim.tbl_isempty(result) then
      print("No location found!")
    else
      if vim.tbl_islist(result) then
        M.floating_buf, M.floating_win = M.preview_location(result[1], context)
      else
        M.floating_buf, M.floating_win = M.preview_location(result, context)
      end
    end
  end
end

M.peek_declaration = function()
  if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
    vim.api.nvim_set_current_win(M.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/declaration", params,
                               M.preview_location_callback)
  end
end

M.peek_definition = function()
  if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
    vim.api.nvim_set_current_win(M.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params,
                               M.preview_location_callback)
  end
end

return M
