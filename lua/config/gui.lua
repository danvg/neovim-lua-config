local default_font_family = "monospace"
local default_font_size = 13

local font = {
  family = (function()
    if string.match(vim.loop.os_uname().sysname, "[w|W]indows") ~= nil then
      return "JetBrainsMono NF"
    else
      return default_font_family
    end
  end)(),
  size = default_font_size,
}

local function update_font()
  local str = string.format("GuiFont! %s:h%d", font.family, font.size)
  vim.cmd(str)
end

local function increase_font_size()
  font.size = font.size + 1
  update_font()
end

local function decrease_font_size()
  font.size = font.size - 1
  update_font()
end

local function reset_font_size()
  font.size = default_font_size
  update_font()
end

local function set_keymaps()
  -- font
  vim.keymap.set("n", "<C-+>", increase_font_size)
  vim.keymap.set("n", "<C-->", decrease_font_size)
  vim.keymap.set("n", "<C-0>", reset_font_size)
  -- context menu
  vim.keymap.set("n", "<RightMouse>", ":call GuiShowContextMenu()<CR>")
  vim.keymap.set("i", "<RightMouse>", "<ESC>:call GuiShowContextMenu()<CR>")
  vim.keymap.set("x", "<RightMouse>", ":call GuiShowContextMenu()<CR>gv")
  vim.keymap.set("s", "<RightMouse>", "<C-G>:call GuiShowContextMenu()<CR>gv")
end

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    local user_cmds = vim.api.nvim_get_commands({})
    if user_cmds["GuiFont"] then
      update_font()
      set_keymaps()
    else
      vim.notify("Not running inside nvim-qt.")
    end
  end,
})
