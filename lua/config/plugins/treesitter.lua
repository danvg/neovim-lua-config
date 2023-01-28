return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufEnter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "c", "cpp", "java" },
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = { enable = true },
      })
    end,
  },
  { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
}
