local M = {}

local function on_windows_os()
  return string.match(vim.loop.os_uname().sysname, "[w|W]indows") ~= nil
end

local default_font_family = (function()
  if vim.env.EDITOR_FONT_FAMILY ~= nil then
    return vim.env.EDITOR_FONT_FAMILY
  else
    if on_windows_os() then
      return "Consolas"
    else
      return "monospace"
    end
  end
end)()

local default_font_size = vim.env.EDITOR_FONT_SIZE or 9

local font = {
  family = default_font_family,
  size = default_font_size,
}

local function update_font()
  vim.opt.guifont = font.family .. ":h" .. font.size
end

local function increase_font_size()
  font.size = font.size + 1
  vim.notify("Font size increase to " .. tostring(font.size))
  update_font()
end

local function decrease_font_size()
  font.size = font.size - 1
  vim.notify("Font size decrease to " .. tostring(font.size))
  update_font()
end

local function reset_font_size()
  font.size = default_font_size
  vim.notify("Font size reset to " .. tostring(font.size))
  update_font()
end

local function set_keymaps()
  vim.keymap.set("n", "<C-+>", increase_font_size)
  vim.keymap.set("n", "<C-_>", decrease_font_size)
  vim.keymap.set("n", "<C-0>", reset_font_size)
end

M.setup = function()
  vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
      update_font()
      set_keymaps()
    end,
  })
end

return M
