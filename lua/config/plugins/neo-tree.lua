return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = "<leader>e",
  config = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      window = {
        mappings = {
          ["<space>"] = "noop",
        },
      },
    })
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
  end,
}
