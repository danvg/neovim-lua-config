return {
  "numToStr/Comment.nvim",
  event = { "BufRead", "BufEnter" },
  config = function()
    require("Comment").setup()
  end,
}
