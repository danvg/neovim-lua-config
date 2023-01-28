return {
  "nvim-telescope/telescope.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  cmd = "Telescope",
  keys = { "<leader>ff", "<leader>fg", "<leader>fn" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local sorters = require("telescope.sorters")
    local previewers = require("telescope.previewers")
    local builtin = require("telescope.builtin")

    telescope.setup({
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
          ".git",
          "node_modules/*",
          "NTUSER*",
          "ntuser*",
          "desktop.ini",
          "packer_compiled.lua",
          "spell/*",
          "**/*.class",
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

    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end)
    vim.keymap.set("n", "<leader>fg", builtin.live_grep)
    vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    vim.keymap.set("n", "<leader>fc", builtin.colorscheme)
    vim.keymap.set("n", "<leader>fb", builtin.buffers)
    vim.keymap.set("n", "<leader>gf", builtin.git_files)
    vim.keymap.set("n", "<leader>gc", builtin.git_commits)
    vim.keymap.set("n", "<leader>gb", builtin.git_branches)
    vim.keymap.set("n", "<leader>gs", builtin.git_status)
  end,
}
