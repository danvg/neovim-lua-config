vim.keymap.set("n", "<leader>q", function()
  require("bufdelete").bufdelete(0, true)
end)
