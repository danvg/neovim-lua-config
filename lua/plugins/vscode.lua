local vscode_ok, vscode = pcall(require, "vscode")
if not vscode_ok then
  vim.notify("VSCode colorscheme module not found!")
  return
end

_G.ToggleStyleFun = function()
  if vim.g.vscode_style == "dark" then
    vscode.change_style("light")
  elseif vim.g.vscode_style == "light" then
    vscode.change_style("dark")
  else
    vim.notify("No style set")
  end
end

vim.g.vscode_style = "dark"
vim.cmd [[
  colorscheme vscode
  command! ToggleStyle call v:lua.ToggleStyleFun()
]]
