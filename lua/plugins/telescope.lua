local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  vim.notify("telescope module not found!")
  return
end

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg", "--no-heading", "--with-filename", "--line-number", "--column",
      "--smart-case"
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
      vertical = { mirror = false }
    },
    file_sorter = sorters.get_fzy_file,
    file_ignore_patterns = {
      ".git", "node_modules/*", "NTUSER*", "ntuser*", "desktop.ini"
    },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
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
        ["<CR>"] = actions.select_default + actions.center

        -- You can perform as many actions in a row as you like
        -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
        -- ["<C-i>"] = my_cool_custom_action,
      }
    }
  },
  extensions = {
    fzy_native = { override_generic_sorter = false, override_file_sorter = true },
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" }
    }
  }
})

telescope.load_extension("fzy_native")
telescope.load_extension("media_files")

local set_keymap = require("keymap_util").set_keymap
set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
set_keymap("n", "<leader>fn",
           ":lua require('telescope.builtin').find_files{cwd=vim.fn.stdpath('config')}<CR>")
set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
set_keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<CR>")
set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
set_keymap("n", "<leader>gf", "<cmd>Telescope git_files<CR>")
set_keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
set_keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
set_keymap("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
