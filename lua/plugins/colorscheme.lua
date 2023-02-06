return {
  "catppuccin/nvim",
  name = "catppuccin",
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
    if
      vim.env.EDITOR_NIGHT_LIGHT ~= nil
      and vim.env.EDITOR_NIGHT_LIGHT == "1"
    then
      local s = vim.env.EDITOR_NIGHT_LIGHT_START
          and vim.env.EDITOR_NIGHT_LIGHT_START
        or "18:00"

      local e = vim.env.EDITOR_NIGHT_LIGHT_END
          and vim.env.EDITOR_NIGHT_LIGHT_END
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
        vim.opt.background = "dark"
        opts.flavour = opts.background.dark
      else
        vim.opt.background = "light"
        opts.flavour = opts.background.light
      end
    end

    require("catppuccin").setup(opts)
    vim.cmd([[colorscheme catppuccin]])
  end,
}
