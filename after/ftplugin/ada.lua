-- Disable mapping that prohibits space to be mapped as leader key
pcall(vim.keymap.del, "i", "<Space>aj", { silent = true, buffer = true })
pcall(vim.keymap.del, "i", "<Space>al", { silent = true, buffer = true })

local function to_string(data)
  if data == nil or #data == 0 then
    return nil
  end

  local str
  if type(data) == "table" then
    str = ""
    for _, value in ipairs(data) do
      str = str .. value
    end
  else
    str = tostring(data)
  end
  str = string.gsub(str, "\r", "\n")
  return str
end

local function command(cmd_name, exe_path)
  vim.api.nvim_create_user_command(cmd_name, function(t)
    local cmd = { exe_path }
    if #t.fargs > 0 then
      local cmd_with_args = vim.tbl_extend("keep", cmd, t.fargs)
      if cmd_with_args then
        cmd = cmd_with_args
      end
    end

    local jobid = vim.fn.jobstart(cmd, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_exit = function(_, code)
        print(exe_path .. " exited with code " .. tostring(code))
      end,
      on_stdout = function(_, data)
        local str = to_string(data)
        if str then
          print(str)
        end
      end,
      on_stderr = function(_, data)
        local str = to_string(data)
        if str then
          print(str)
        end
      end,
    })
    vim.fn.jobwait({ jobid })
  end, { bang = true, nargs = "*", complete = "file" })
end

command("GprBuild", vim.fn.exepath("gprbuild"))
command("GprClean", vim.fn.exepath("gprclean"))
command("GprPretty", vim.fn.exepath("gnatpp"))
