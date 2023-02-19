local colorscheme = "default"
local env_colorscheme = vim.fn.getenv("EDITOR_COLORSCHEME")
if env_colorscheme ~= nil then
  if env_colorscheme == "catppuccin" then
    colorscheme = "catppuccin"
  elseif env_colorscheme == "gruvbox" then
    colorscheme = "gruvbox"
  else
    vim.notify(
      "Unknown environment defined colorscheme " .. env_colorscheme,
      "warning"
    )
  end
end

--- Get which night light mode to use given the current time.
--- @return "dark"|"light"
local function night_light()
  local mode = "dark"

  if
    vim.env.EDITOR_NIGHT_LIGHT ~= nil and vim.env.EDITOR_NIGHT_LIGHT == "1"
  then
    local s = vim.env.EDITOR_NIGHT_LIGHT_START
        and vim.env.EDITOR_NIGHT_LIGHT_START
      or "18:00"

    local e = vim.env.EDITOR_NIGHT_LIGHT_END and vim.env.EDITOR_NIGHT_LIGHT_END
      or "08:00"

    local today = os.date("%Y-%m-%d")
    assert(type(today) == "string")
    local year, month, day = string.match(today, "([%d]+)-([%d]+)-([%d]+)")

    local sh, sm = s:match("([^:]+):([^:]+)")
    local eh, em = e:match("([^:]+):([^:]+)")

    local tt = { year = year, month = month, day = day }
    local stt = vim.tbl_extend("force", tt, { hour = sh, min = sm })
    local ett = vim.tbl_extend("force", tt, { hour = eh, min = em })

    local st = os.time(stt)
    local et = os.time(ett)
    local ct = os.time()

    if et < st then
      ett.day = ett.day + 1
      et = os.time(ett)
    end

    if ct >= st and ct <= et then
      mode = "dark"
    else
      mode = "light"
    end
  end
  return mode
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = colorscheme == "catppuccin",
    lazy = false,
    priority = 9999,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
    },
    config = function(_, opts)
      if night_light() == "dark" then
        vim.opt.background = "dark"
        opts.flavour = opts.background.dark
      else
        vim.opt.background = "light"
        opts.flavour = opts.background.light
      end
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    enabled = colorscheme == "gruvbox",
    lazy = false,
    priority = 9999,
    config = function()
      if night_light() == "dark" then
        vim.opt.background = "dark"
      else
        vim.opt.background = "light"
      end
      require("gruvbox").setup({})
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
