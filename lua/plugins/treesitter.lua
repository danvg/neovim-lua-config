return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "p00f/nvim-ts-rainbow",
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup({
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
          filetypes = { "html", "typescriptreact" },
        })
      end,
    },
  },
  event = { "BufRead", "BufEnter" },
  opts = {
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
  },
  config = true,
}
