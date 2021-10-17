local formatters_root = vim.fn.stdpath("data") .. "/formatters"
if vim.fn.isdirectory(formatters_root) then
  local prettier = {
    function()
      return {
        exe = formatters_root .. "/node_modules/.bin/prettier",
        args = {
          "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
        },
        stdin = true
      }
    end
  }

  local clang_format = {
    function()
      return {
        exe = "clang-format",
        args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
        stdin = true
      }
    end
  }

  local cmake_format = {
    function()
      return {
        exe = formatters_root .. "/venv/Scripts/cmake-format",
        args = { vim.api.nvim_buf_get_name(0) },
        stdin = true
      }
    end
  }

  local lua_format = {
    function()
      return {
        exe = formatters_root .. "/LuaFormatter/lua-format",
        args = {
          vim.api.nvim_buf_get_name(0),
          "--config=" .. vim.fn.stdpath("config") .. "/.lua-format"
        },
        stdin = true
      }
    end
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
      lua = lua_format
    }
  })
end
