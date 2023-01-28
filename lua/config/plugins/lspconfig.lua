return {
  "neovim/nvim-lspconfig",
  requires = {
    { "ray-x/lsp_signature.nvim" },
    { "SmiteshP/nvim-navic" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
  },
  config = function()
    local lspconfig = require("lspconfig")

    require("mason").setup({
      ui = {
        border = "single",
        icons = {
          server_installed = "✓",
          server_pending = "➜",
          server_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup()

    local on_attach = function(client, bufnr)
      require("lsp_signature").on_attach()
      require("nvim-navic").attach(client, bufnr)

      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      -- Mappings.
      local function buf_map(mode, lhs, rhs)
        local opts = { silent = true, buffer = bufnr }
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_map("n", "gD", vim.lsp.buf.declaration)
      buf_map("n", "gd", vim.lsp.buf.definition)
      buf_map("n", "K", vim.lsp.buf.hover)
      buf_map("n", "gi", vim.lsp.buf.implementation)
      buf_map("n", "<C-k>", vim.lsp.buf.signature_help)
      buf_map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
      buf_map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
      buf_map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_foders()))
      end)
      buf_map("n", "<leader>ds", function()
        print(vim.inspect(vim.lsp.buf.document_symbol()))
      end)
      buf_map("n", "<leader>D", vim.lsp.buf.type_definition)
      buf_map("n", "<leader>rn", vim.lsp.buf.rename)
      buf_map("n", "<leader>ca", vim.lsp.buf.code_action)
      buf_map("n", "gr", vim.lsp.buf.references)
      buf_map("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end)

      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.format({ async = true })
      end, {
        bang = true,
      })
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.document_formatting = false
    capabilities.document_range_formatting = false
    local flags = { debounce_text_changes = 150 }

    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
          border = "single",
        }
      ),
    }

    local lsp_opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      handlers = handlers,
    }

    local function setup_als()
      local mason_reg = require("mason-registry")

      if not mason_reg.has_package("ada-language-server") then
        vim.notify("Mason ada-language-server package missing")
        return
      end

      local opts = vim.tbl_extend("force", lsp_opts, {})

      opts.cmd = { vim.fn.stdpath("data") .. "/mason/bin/ada_language_server" }

      opts.on_init = function(client)
        local available =
          vim.fn.expand(client.config.root_dir .. "/*.gpr", true, true)
        local chosen

        if available == nil or #available == 0 then
          chosen = nil
        elseif #available == 1 then
          chosen = available[1]
        else
          vim.notify("Selecting a project file...")
          vim.ui.select(
            available,
            { prompt = "Select a project file:" },
            function(choice)
              if choice == nil then
                chosen = available[1]
              else
                chosen = choice
              end
            end
          )
        end

        client.config.settings = { ada = { projectFile = chosen } }
        print("[als] Using project file: " .. chosen)
        client.notify("workspace/didChangeConfiguration")
        return true
      end

      lspconfig.als.setup(opts)
    end

    local function setup_sumneko_lua()
      local opts = vim.tbl_extend("force", lsp_opts, {})

      opts.settings = {
        Lua = {
          diagnostics = { globals = { "vim", "packer_plugins" } },
          telemetry = { enable = false },
          format = { enable = false },
        },
      }

      lspconfig.sumneko_lua.setup(opts)
    end

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup(lsp_opts)
      end,
      ["als"] = setup_als,
      ["sumneko_lua"] = setup_sumneko_lua,
    })
  end,
}
