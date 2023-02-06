return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>ee",
      "<cmd>Neotree filesystem<cr>",
      "n",
      desc = "Shows the file explorer",
    },
    {
      "<leader>eg",
      "<cmd>Neotree git_status<cr>",
      "n",
      desc = "Shows the git status",
    },
    {
      "<leader>eb",
      "<cmd>Neotree buffers<cr>",
      "n",
      desc = "Shows the open buffers",
    },
    {
      "<leader>ec",
      "<cmd>Neotree close<cr>",
      "n",
      desc = "Close explorer",
    },
  },
  config = function()
    vim.g.neo_tree_remove_legacy_commands = 1

    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "noop",
        },
      },
    })
  end,
}
