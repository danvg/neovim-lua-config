_G.ToggleStyleFun = function()
  if vim.g.vscode_style == "dark" then
    require("vscode").change_style("light")
  elseif vim.g.vscode_style == "light" then
    require("vscode").change_style("dark")
  else
    vim.notify("No style set")
  end
end

vim.g.vscode_style = "dark"
vim.api.nvim_exec([[
  colorscheme vscode
  command! ToggleStyle call v:lua.ToggleStyleFun()
]], false)
