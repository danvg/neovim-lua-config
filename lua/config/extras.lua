local function strip_trailing_spaces()
  local save = vim.fn.winsaveview()
  vim.cmd([[%s/\v\s+$//e]])
  vim.fn.winrestview(save)
end

local function web_search(term)
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

local function web_search_cw()
  local cword = vim.fn.expand("<cword>", false, false)
  web_search(cword)
end

vim.api.nvim_create_user_command(
  "StripTrailingSpaces",
  strip_trailing_spaces,
  { bang = true }
)

vim.api.nvim_create_user_command(
  "WebSearch",
  web_search,
  { bang = true, nargs = "*" }
)

vim.api.nvim_create_user_command("WebSearchCW", web_search_cw, { bang = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 800 })
  end,
})
