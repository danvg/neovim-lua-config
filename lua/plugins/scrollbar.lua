return {
  "petertriho/nvim-scrollbar",
  event = { "BufEnter", "BufNew" },
  config = function()
    require("scrollbar").setup({
      excluded_filetypes = {
        "TelescopePrompt",
        "alpha",
      },
    })
  end,
}
