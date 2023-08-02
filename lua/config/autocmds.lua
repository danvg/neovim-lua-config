local M = {}

M.setup = function()
  local autocmd = vim.api.nvim_create_autocmd
  local group = vim.api.nvim_create_augroup("ConfigGroup", { clear = true })

  -- highlight on yank
  autocmd("TextYankPost", {
    group = group,
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- got to last known location when opening a buffer
  autocmd("BufReadPost", {
    group = group,
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- options for text type files
  autocmd("FileType", {
    group = group,
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- close some filetypes with q
  autocmd("FileType", {
    group = group,
    pattern = {
      "qf",
      "help",
      "man",
      "notify",
      "lspinfo",
      "startuptime",
      "tsplayground",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set(
        "n",
        "q",
        "<cmd>close<cr>",
        { buffer = event.buf, silent = true }
      )
    end,
  })

  -- XML-like files
  autocmd({ "BufNewFile", "BufRead" }, {
    group = group,
    pattern = { "*.xaml", "*.axaml" },
    callback = function()
      vim.cmd.setf("xml")
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
      vim.bo.shiftwidth = 4
    end,
  })
end

return M
