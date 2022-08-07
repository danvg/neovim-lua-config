local command = vim.api.nvim_create_user_command

local strip_trailing_spaces = function()
  local save = vim.fn.winsaveview()
  vim.cmd([[%s/\v\s+$//e]])
  vim.fn.winrestview(save)
end

local web_search = function(term)
  local url = "http://www.google.com/search?q=" .. term
  if vim.fn.has("Win32") then
    vim.loop.spawn(
      "rundll32",
      { args = { "url.dll,FileProtocolHandler", url } }
    )
  else
    vim.loop.spawn("xdg-open", { args = { url } })
  end
end

local web_search_cw = function()
  local cword = vim.fn.expand("<cword>")
  web_search(cword)
end

command("StripTrailingSpaces", strip_trailing_spaces, { bang = true })
command("WebSearch", web_search, { bang = true, nargs = 1 })
command("WebSearchCW", web_search_cw, { bang = true })
