require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "c", "cpp", "java" },
  highlight = { enable = true },
  indent = { enable = true },
  rainbow = { enable = true },
})
