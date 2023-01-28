return {
  "norcalli/nvim-colorizer.lua",
  event = { "BufRead", "BufEnter" },
  config = function()
    require("colorizer").setup()
  end,
}
