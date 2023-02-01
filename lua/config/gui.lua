local M = {}

local function on_windows_os()
  return string.match(vim.loop.os_uname().sysname, "[w|W]indows") ~= nil
end

local default_font_family = (function()
  if vim.env.EDITOR_FONT_FAMILY ~= nil then
    return vim.env.EDITOR_FONT_FAMILY
  else
    if on_windows_os() then
      return "JetBrainsMono NF"
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
  local str = string.format("GuiFont! %s:h%d", font.family, font.size)
  vim.cmd(str)
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
  -- font
  vim.keymap.set("n", "<C-+>", increase_font_size)
  vim.keymap.set("n", "<C-_>", decrease_font_size)
  vim.keymap.set("n", "<C-0>", reset_font_size)
  -- context menu
  vim.keymap.set(
    "n",
    "<RightMouse>",
    ":call GuiShowContextMenu()<CR>",
    { silent = true }
  )
  vim.keymap.set(
    "i",
    "<RightMouse>",
    "<ESC>:call GuiShowContextMenu()<CR>",
    { silent = true }
  )
  vim.keymap.set(
    "x",
    "<RightMouse>",
    ":call GuiShowContextMenu()<CR>gv",
    { silent = true }
  )
  vim.keymap.set(
    "s",
    "<RightMouse>",
    "<C-G>:call GuiShowContextMenu()<CR>gv",
    { silent = true }
  )
end

M.setup = function()
  vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
      local user_cmds = vim.api.nvim_get_commands({})
      if user_cmds["GuiFont"] then
        update_font()
        set_keymaps()
      end
    end,
  })
end

return M
