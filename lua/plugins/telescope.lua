return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  cmd = "Telescope",
  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files<cr>",
      desc = "Find files",
    },
    {
      "<leader>fn",
      "<cmd>Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<cr>",
      desc = "Find Neovim config files",
    },
    {
      "<leader>fg",
      "<cmd>Telescope live_grep<cr>",
      desc = "Live grep in current directory",
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
      desc = "Find help tags",
    },
    {
      "<leader>fc",
      "<cmd>Telescope colorscheme<cr>",
      desc = "Find colorscheme",
    },
    {
      "<leader>fb",
      "<cmd>Telescope buffers<cr>",
      desc = "Find buffer",
    },
    {
      "<leader>gf",
      "<cmd>Telescope git_files<cr>",
      desc = "Find git file",
    },
    {
      "<leader>gc",
      "<cmd>Telescope git_commits<cr>",
      desc = "Find git commits",
    },
    {
      "<leader>gb",
      "<cmd>Telescope git_branches<cr>",
      desc = "Find git branches",
    },
    {
      "<leader>gs",
      "<cmd>Telescope git_status<cr>",
      desc = "Find git status",
    },
  },
  config = function()
    local actions = require("telescope.actions")
    local sorters = require("telescope.sorters")
    local previewers = require("telescope.previewers")

    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim",
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { mirror = false },
          vertical = { mirror = false },
        },
        file_sorter = sorters.get_fzy_file,
        file_ignore_patterns = {
          ".git/",
          "node_modules/",
          "%.class",
          "NTUSER%",
          "ntuser%",
          "desktop.ini",
          "%.sug",
          "%.spl",
          "%thesaurus.txt",
        },
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = previewers.buffer_previewer_maker,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            -- To disable a keymap, put [map] = false
            -- So, to not map "<C-n>", just put
            -- ["<c-x>"] = false,
            ["<esc>"] = actions.close,
            -- Otherwise, just set the mapping to the function that you want it to be.
            -- ["<C-i>"] = actions.select_horizontal,

            -- Add up multiple actions
            ["<CR>"] = actions.select_default + actions.center,

            -- You can perform as many actions in a row as you like
            -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            -- ["<C-i>"] = my_cool_custom_action,
          },
        },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
      },
    })

    require("telescope").load_extension("fzy_native")
  end,
}
