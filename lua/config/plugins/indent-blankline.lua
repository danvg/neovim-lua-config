return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufRead", "BufNew" },
  config = function()
    require("indent_blankline").setup()
  end,
}
