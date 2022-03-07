function _G.StripTrailingSpaces()
  local save = vim.fn.winsaveview()
  vim.cmd [[%s/\v\s+$//e]]
  vim.fn.winrestview(save)
end

vim.cmd [[command! StripTrailingSpaces lua _G.StripTrailingSpaces()]]

local url_prefix = "http://www.google.com/search?q="

function _G.WebSearch(term)
  local url = url_prefix .. term
  if vim.fn.has("Win32") then
    vim.loop
      .spawn("rundll32", { args = { "url.dll,FileProtocolHandler", url } })
  else
    vim.loop.spawn("xdg-open", { args = { url } })
  end
end

function _G.WebSearchCW()
  local cword = vim.fn.expand("<cword>")
  _G.WebSearch(cword);
end

vim.cmd [[command! -nargs=1 WebSearch lua _G.WebSearch(<f-args>)]]
vim.cmd [[command! WebSearchCW lua _G.WebSearchCW()]]
