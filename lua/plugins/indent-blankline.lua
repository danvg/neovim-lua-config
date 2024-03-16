return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufRead", "BufNew" },
  config = function ()
    require("ibl").setup()
  end,
}
