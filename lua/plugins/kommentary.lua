local config_ok, config = pcall(require, "kommentary.config")
if not config_ok then
  vim.notify("kommentary config module not found!")
  return
end

config.use_extended_mappings()
