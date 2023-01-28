return {
  "kyazdani42/nvim-tree.lua",
  requires = {
    "kyazdani42/nvim-web-devicons",
  },
  cmd = "NvimTreeToggle",
  keys = "<leader>e",
  config = function()
    require("nvim-tree").setup({
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
  end,
}
