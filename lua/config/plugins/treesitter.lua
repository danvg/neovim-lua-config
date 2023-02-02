return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufEnter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "ada",
          "bash",
          "c",
          "cmake",
          "comment",
          "cpp",
          "css",
          "gitcommit",
          "gitignore",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "ninja",
          "todotxt",
          "typescript",
          "vim",
        },
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = { enable = true },
      })
    end,
  },
  { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
}
