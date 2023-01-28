return {
  "stevearc/aerial.nvim",
  cmd = { "AerialOpen", "AerialToggle" },
  config = function()
    require("aerial").setup()
  end,
}
