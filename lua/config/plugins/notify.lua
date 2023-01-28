return {
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = function(msg, ...)
      if msg:match("warning: multiple different client offset_encodings") then
        return
      end
      require("notify")(msg, ...)
    end
  end,
}
