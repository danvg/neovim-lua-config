return {
  "lewis6991/gitsigns.nvim",
  event = { "BufEnter", "BufNew" },
  config = function()
    require("gitsigns").setup({})
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
