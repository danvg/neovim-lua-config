return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "SmiteshP/nvim-navic",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "mfussenegger/nvim-jdtls",
    "folke/neodev.nvim",
    "nvimtools/none-ls.nvim",
    "j-hui/fidget.nvim",
  },
  config = function()
    require("neodev").setup({})

    require("mason").setup({
      PATH = "append", -- Use the system binary if available
      ui = {
        border = "single",
        icons = {
          server_installed = "✓",
          server_pending = "➜",
          server_uninstalled = "✗",
        },
      },
    })

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = {
        "clangd",
        "cmake",
        "cssls",
        "html",
        "jdtls",
        "jsonls",
        "lua_ls",
        "pyright",
        "ts_ls",
        "vimls",
      },
    })

    vim.g.navic_silence = true

    local lsp_opts = {
      on_attach = function(client, bufnr)
        require("nvim-navic").attach(client, bufnr)
        require("config.lsp").on_attach(client, bufnr)
      end,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      flags = require("config.lsp").flags,
      handlers = require("config.lsp").handlers,
    }

    -- let null-ls take care of it
    lsp_opts.capabilities.document_formatting = false
    lsp_opts.capabilities.document_range_formatting = false

    local function setup_clangd()
      local clangd_opts = vim.tbl_extend("force", lsp_opts, {})

      clangd_opts.cmd = {
        vim.fn.exepath("clangd"),
        "--enable-config",
        "--background-index",
        "--pch-storage=memory",
        "--all-scopes-completion",
        "--header-insertion=iwyu",
        "--fallback-style=Google",
        "--clang-tidy",
        "--compile-commands-dir=build",
      }

      require("lspconfig").clangd.setup(clangd_opts)
    end

    local function setup_lua_ls()
      local lua_ls_opts = vim.tbl_extend("force", lsp_opts, {})

      lua_ls_opts.settings = {
        Lua = {
          diagnostics = { globals = { "vim", "packer_plugins" } },
          telemetry = { enable = false },
          format = { enable = false },
          hint = { enable = true },
        },
      }

      require("lspconfig").lua_ls.setup(lua_ls_opts)
    end

    mason_lspconfig.setup_handlers({
      function(server)
        require("lspconfig")[server].setup(lsp_opts)
      end,
      ["clangd"] = setup_clangd,
      ["jdtls"] = function() end,
      ["lua_ls"] = setup_lua_ls,
    })

    require("fidget").setup({})

    local lsp_fmt_au_group
    vim.api.nvim_create_augroup("LspFormatting", {})
    local null_ls = require("null-ls")
    null_ls.setup({
      on_attach = function(client, bufnr)
        -- Add auto-formatting
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = lsp_fmt_au_group,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_fmt_au_group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end,
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.prettier,
      },
    })

    vim.api.nvim_create_user_command("Format", function()
      vim.lsp.buf.format({ async = true })
    end, {
      bang = true,
    })
  end,
}
