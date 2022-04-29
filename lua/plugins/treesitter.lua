local configs_ok, configs = pcall(require, "nvim-treesitter.configs")
if not configs_ok then
  vim.notify("Treesitter configs module not found!")
  return
end

configs.setup({
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = true },
  rainbow = { enable = true }
})
