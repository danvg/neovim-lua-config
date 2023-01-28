return {
  "hoob3rt/lualine.nvim",
  requires = { "SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons" },
  event = { "BufRead", "BufNew" },
  config = function()
    local function breadcrumbs()
      local navic = require("nvim-navic")
      if navic.is_available() then
        return navic.get_location({})
      else
        return ""
      end
    end
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "NvimTree" },
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          "filename",
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      inactive_tabline = {},
      winbar = {
        -- lualine_c = { "%=%m %F" },
        lualine_c = { breadcrumbs },
      },
      inactive_winbar = {
        lualine_c = { "%=%m %F" },
      },
      extensions = { "quickfix", "nvim-tree" },
    })
  end,
}
