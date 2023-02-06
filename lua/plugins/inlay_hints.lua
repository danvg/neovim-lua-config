return {
  "lvimuser/lsp-inlayhints.nvim",
  lazy = true,
  config = true,
  init = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, bufnr, false)

        vim.api.nvim_buf_create_user_command(bufnr, "InlayHintsShow", function()
          require("lsp-inlayhints").show(bufnr)
        end, {
          force = true,
          desc = "Fetch and show the lsp inlay hints",
        })

        vim.api.nvim_buf_create_user_command(
          bufnr,
          "InlayHintsToggle",
          function()
            require("lsp-inlayhints").toggle()
          end,
          {
            force = true,
            desc = "Toggle the lsp inlay hints",
          }
        )

        vim.api.nvim_buf_create_user_command(
          bufnr,
          "InlayHintsReset",
          function()
            require("lsp-inlayhints").reset(bufnr)
          end,
          {
            force = true,
            desc = "Clears all hints in the buffer",
          }
        )
      end,
    })
  end,
}
