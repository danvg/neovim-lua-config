local telescope_utils = {}

-- Telescope search in the dotfiles directory
function telescope_utils.search_dotfiles()
  require("telescope.builtin").find_files(
    {prompt_title = "Dotfiles", cwd = "$HOME/.dotfiles/"})
end

-- Telescope search in the nvim config directory
function telescope_utils.search_nvim_config()
  require("telescope.builtin").find_files(
    {prompt_title = "Neovim Config", cwd = vim.fn.stdpath("config") .. "/"})
end

return telescope_utils

