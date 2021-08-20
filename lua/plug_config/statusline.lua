local galaxyline = require("galaxyline")
local section = galaxyline.section
local colors = require("colors")
local condition = require("galaxyline.condition")


galaxyline.short_line_list = {
  "NvimTree", "vista", "dbui", "packer", "undotree_2", "startify"
}

local icons = {
  left = "",
  right = " ",
  vi_mode_icon = "  ",
  position_icon = " ",
  lsp_icon = "  "
}

local mode_color = {
  n = colors.red,
  i = colors.green,
  v = colors.violet,
  [""] = colors.violet,
  V = colors.violet,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [""] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red
}

local function left(args) table.insert(section.left, args) end
local function right(args) table.insert(section.right, args) end
local function sleft(args) table.insert(section.short_line_left, args) end
local function sright(args) table.insert(section.short_line_right, args) end

left({
  ViMode = {
    provider = function()
      vim.api
        .nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
      return " " .. icons.vi_mode_icon .. " "
    end,
    highlight = { colors.red, colors.bg3, "bold" }
  }
})

left({
  CurrentDir = {
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return "  " .. dir_name .. " "
    end,
    highlight = { colors.yellow, colors.bg3 }

  }
})

left({
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = {
      require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg3
    }
  }
})

left({
  FileName = {
    provider = "FileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.magenta, colors.bg3, "bold" }
  }
})





left({
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = { colors.red, colors.bg3 }
  }
})

left({
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = { colors.yellow, colors.bg3 }
  }
})

left({
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = { colors.cyan, colors.bg3 }
  }
})

left({
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    highlight = { colors.violet, colors.bg3 }
  }
})

right({
  ShowLspClient = {
    provider = "GetLspClient",
    condition = function()
      local tbl = { ["dashboard"] = true, [""] = true }
      if tbl[vim.bo.filetype] then return false end
      return true
    end,
    icon = icons.lsp_icon,
    highlight = { colors.cyan, colors.bg3, "bold" }
  }
})

right({
  GitIcon = {
    provider = function() return " " end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { colors.bg3, colors.bg3 },
    highlight = { colors.violet, colors.bg3, "bold" }
  }
})

right({
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { colors.bg3, colors.bg3 },
    highlight = { colors.violet, colors.bg3, "bold" }
  }
})

right({
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.green, colors.bg3 }
  }
})

right({
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.orange, colors.bg3 }
  }
})

right({
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.red, colors.bg3 }
  }
})

right({
  FileSize = {
    provider = "FileSize",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg3 }
  }
})

right({
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { colors.bg3, colors.bg3 },
    highlight = { colors.fg, colors.bg3, "bold" }
  }
})

right({
  FileFormat = {
    provider = "FileFormat",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { colors.bg3, colors.bg3 },
    highlight = { colors.fg, colors.bg3, "bold" }
  }
})

right({
  PerCent = {
    provider = "LinePercent",
    highlight = { colors.fg, colors.bg3, "bold" },
    icon = icons.position_icon,
    separator = " ",
    separator_highlight = { colors.bg3, colors.bg3 }
  }
})

sleft({
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = { colors.bg3, colors.bg3 },
    highlight = { colors.fg, colors.bg3, "bold" }
  }
})

sleft({
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg3, "bold" }
  }
})

sright({
  BufferIcon = { provider = "BufferIcon", highlight = { colors.fg, colors.bg3 } }
})
