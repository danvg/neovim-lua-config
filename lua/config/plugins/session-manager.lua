return {
  "Shatur/neovim-session-manager",
  event = "BufWritePost",
  cmd = "SessionManager",
  config = function()
    require("session_manager").setup({
      autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
    })
  end,
}
