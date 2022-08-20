local lang_tools = require("config.lang_tools")

local prettier = {
  function()
    return {
      exe = lang_tools.get_mason_cmd("prettier"),
      args = {
        "--stdin-filepath",
        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      },
      stdin = true,
    }
  end,
}

local clang_format = {
  function()
    return {
      exe = lang_tools.get_mason_cmd("clang-format"),
      args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
      stdin = true,
    }
  end,
}

local cmake_format = {
  function()
    return {
      exe = lang_tools.get_mason_cmd("cmake-format"),
      args = { vim.api.nvim_buf_get_name(0) },
      stdin = true,
    }
  end,
}

local lua_format = {
  function()
    return {
      exe = lang_tools.get_mason_cmd("stylua"),
      args = {
        "--stdin-filepath=" .. vim.api.nvim_buf_get_name(0),
        "--column-width=80",
        "--indent-type=Spaces",
        "--indent-width=2",
        "--line-endings=Unix",
        "--quote-style=AutoPreferDouble",
      },
      stdin = false,
    }
  end,
}

require("formatter").setup({
  filetype = {
    json = prettier,
    yaml = prettier,
    javascript = prettier,
    typescript = prettier,
    html = prettier,
    css = prettier,
    c = clang_format,
    cpp = clang_format,
    cmake = cmake_format,
    lua = lua_format,
  },
})
