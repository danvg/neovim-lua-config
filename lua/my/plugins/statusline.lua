local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")
local colors = require("my.core.colors")

-- keeping this table { } as empty will show inactive statuslines
gl.short_line_list = {" "}

local icons = {
  home = "",
  desktop = "",
  dotfiles = "",
  nvim_config = "",
  directory = ""
}

local dirs = {
  home = vim.fn.expand("$HOME"),
  desktop = vim.fn.expand("$HOME/Desktop"),
  nvim_config = vim.fn.stdpath("config"),
  nvim_config_alt = "D:\\Tools\\nvim-lua",
  dotfiles = vim.fn.expand("$HOME/dotfiles")
}

colors.line_bg = "#161616"
colors.light_bg = "#ebdbb2";

gls.left[1] = {
  leftRounded = {
    provider = function() return "" end,
    highlight = {colors.blue, colors.bg}
  }
}

gls.left[2] = {
  folderIcon = {
    provider = function()
      local cwd = vim.fn.getcwd()
      if cwd == dirs.home then
        return " " .. icons.home .. "  "
      elseif cwd == dirs.desktop then
        return " " .. icons.desktop .. "  "
      elseif cwd == dirs.nvim_config then
        return " " .. icons.nvim_config .. "  "
      elseif cwd == dirs.nvim_config_alt then
        return " " .. icons.nvim_config .. "  "
      elseif cwd == dirs.dotfiles then
        return " " .. icons.dotfiles .. "  "
      else
        return " " .. icons.directory .. "  "
      end
    end,
    highlight = {colors.bg, colors.blue},
    separator = " ",
    separator_highlight = {colors.light_bg, colors.light_bg}
  }
}

gls.left[3] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = {
      require("galaxyline.provider_fileinfo").get_file_icon_color,
      colors.light_bg
    }
  }
}

gls.left[4] = {
  FileName = {
    provider = {"FileName", "FileSize"},
    condition = condition.buffer_not_empty,
    highlight = {colors.bg, colors.light_bg}
  }
}

gls.left[5] = {
  leftRoundedEnd = {
    provider = function() return " " end,
    highlight = {colors.light_bg, colors.line_bg}
  }
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then return true end
  return false
end

gls.left[6] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = "  ",
    highlight = {colors.green, colors.line_bg}
  }
}

gls.left[7] = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "  ",
    highlight = {colors.orange, colors.line_bg}
  }
}

gls.left[8] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "  ",
    highlight = {colors.red, colors.line_bg}
  }
}

gls.left[9] = {
  LeftEnd = {
    provider = function() return " " end,
    separator = " ",
    separator_highlight = {colors.line_bg, colors.line_bg},
    highlight = {colors.line_bg, colors.line_bg}
  }
}

gls.left[10] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = {colors.red, colors.line_bg}
  }
}

gls.left[11] = {
  Space = {
    provider = function() return " " end,
    highlight = {colors.line_bg, colors.line_bg}
  }
}

gls.left[12] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = {colors.blue, colors.line_bg}
  }
}

gls.right[1] = {
  GitIcon = {
    provider = function() return "   " end,
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    highlight = {colors.green, colors.line_bg}
  }
}

gls.right[2] = {
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    highlight = {colors.green, colors.line_bg}
  }
}

gls.right[3] = {
  right_LeftRounded = {
    provider = function() return "" end,
    separator = " ",
    separator_highlight = {colors.line_bg, colors.line_bg},
    highlight = {colors.yellow, colors.line_bg}
  }
}

gls.right[4] = {
  ViMode = {
    provider = function()
      local alias = {
        n = "NORMAL",
        i = "INSERT",
        c = "COMMAND",
        V = "VISUAL",
        [""] = "VISUAL",
        v = "VISUAL",
        R = "REPLACE"
      }
      return alias[vim.fn.mode()]
    end,
    highlight = {colors.bg, colors.yellow}
  }
}

gls.right[5] = {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = {colors.yellow, colors.yellow},
    highlight = {colors.bg, colors.fg}
  }
}

gls.right[6] = {
  rightRounded = {
    provider = function() return "" end,
    highlight = {colors.fg, colors.bg}
  }
}
