return {
  "famiu/bufdelete.nvim",
  event = { "BufRead", "BufEnter" },
  config = function()
    vim.keymap.set("n", "<leader>q", function()
      require("bufdelete").bufdelete(0, true)
    end)
  end,
}
