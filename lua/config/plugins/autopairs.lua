return {
  "windwp/nvim-autopairs",
  event = { "BufRead", "BufEnter" },
  config = function()
    require("nvim-autopairs").setup()
  end,
}
