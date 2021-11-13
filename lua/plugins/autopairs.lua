local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
  vim.notify("autopairs module not found!")
  return
end

autopairs.setup()
