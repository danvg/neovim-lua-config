local theme = require("alpha.themes.dashboard")

local buttons = {
  type = "group",
  val = {
    theme.button("e", "  New file", "<cmd>ene <CR>"),
    theme.button("SPC f f", "  Find file", "<cmd>Telescope find_files<CR>"),
    theme.button("SPC f g", "  Find word", "<cmd>Telescope live_grep<CR>"),
    theme.button("SPC f n", "  Configuration"),
    theme.button("r", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
    theme.button("l", "  Open last session", "<cmd>SessionManager load_last_session<CR>"),
    theme.button("u", "  Update plugins", "<cmd>PackerSync<CR>"),
    theme.button("q", "  Quit", "<cmd>qa<CR>"),
  },
  opts = {
    spacing = 1,
  },
}

local config = {
  layout = {
    { type = "padding", val = 2 },
    theme.section.header,
    { type = "padding", val = 2 },
    buttons,
    theme.section.footer,
  },
  opts = {
    margin = 5,
  },
}

require("alpha").setup(config)
