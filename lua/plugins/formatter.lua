local formatter = require("formatter")

local prettier = {
  function()
    return {
      exe = "prettier",
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
      exe = "clang-format",
      args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
      stdin = true,
    }
  end,
}

local cmake_format = {
  function()
    return {
      exe = "cmake-format",
      args = { vim.api.nvim_buf_get_name(0) },
      stdin = true,
    }
  end,
}

local lua_format = {
  function()
    return {
      exe = "stylua",
      args = {
        vim.api.nvim_buf_get_name(0),
        "--config-path=" .. vim.fn.stdpath("config") .. "/stylua.toml",
      },
      stdin = false,
    }
  end,
}

formatter.setup({
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
