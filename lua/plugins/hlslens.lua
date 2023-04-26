return {
  "kevinhwang91/nvim-hlslens",
  event = { "BufEnter", "BufNew" },
  config = function()
    vim.opt.hlsearch = true
    require("scrollbar.handlers.search").setup({
      override_lens = function() end,
    })
  end,
}
