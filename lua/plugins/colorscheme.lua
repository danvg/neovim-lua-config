local available_colorschemes = {
  "catppuccin",
  "gruvbox",
  "github",
  "nightfox",
}

local colorscheme = available_colorschemes[1]

local env_colorscheme = vim.fn.getenv("EDITOR_COLORSCHEME")
if env_colorscheme ~= nil then
  env_colorscheme = env_colorscheme:lower()
  for _, cs in ipairs(available_colorschemes) do
    if cs == env_colorscheme then
      colorscheme = cs
      break
    end
  end
end

--- Get which night light mode to use given the current time.
--- @param change_background? boolean Modifies vim.opt.background.
--- @return "dark"|"light"
local function night_light(change_background)
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

  if type(change_background) == "boolean" and change_background == true then
    vim.opt.background = mode
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
      if night_light(true) == "dark" then
        opts.flavour = opts.background.dark
      else
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
      night_light(true)
      require("gruvbox").setup({})
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    enabled = colorscheme == "github",
    lazy = false,
    priority = 9999,
    config = function()
      local mode = night_light(true)
      require("github-theme").setup({})
      if mode == "light" then
        vim.cmd.colorscheme("github_light")
      else
        vim.cmd.colorscheme("github_dark")
      end
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = colorscheme == "nightfox",
    lazy = false,
    priority = 9999,
    config = function()
      local mode = night_light(true)
      if mode == "light" then
        vim.cmd.colorscheme("dayfox")
      else
        vim.cmd.colorscheme("nightfox")
      end
    end,
  },
}
