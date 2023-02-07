return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "SmiteshP/nvim-navic",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "mfussenegger/nvim-jdtls",
    "folke/neodev.nvim",
    "j-hui/fidget.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    require("neodev").setup({})

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

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = {
        "als",
        "clangd",
        "cmake",
        "cssls",
        "html",
        "jdtls",
        "jsonls",
        "sumneko_lua",
        "pyright",
        "tsserver",
        "vimls",
      },
    })

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

    local function setup_als()
      local als_opts = vim.tbl_extend("force", lsp_opts, {})

      als_opts.cmd = {
        vim.fn.exepath(
          vim.fn.stdpath("data") .. "/mason/bin/ada_language_server"
        ),
      }

      als_opts.on_init = function(client)
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
        vim.notify("Using Ada project file: " .. chosen)
        client.notify("workspace/didChangeConfiguration")
        return true
      end

      require("lspconfig").als.setup(als_opts)
    end

    local function setup_clangd()
      local clangd_opts = vim.tbl_extend("force", lsp_opts, {})

      clangd_opts.cmd = {
        vim.fn.exepath(vim.fn.stdpath("data") .. "/mason/bin/clangd"),
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

    local function setup_sumneko_lua()
      local sumneko_lua_opts = vim.tbl_extend("force", lsp_opts, {})

      sumneko_lua_opts.settings = {
        Lua = {
          diagnostics = { globals = { "vim", "packer_plugins" } },
          telemetry = { enable = false },
          format = { enable = false },
          hint = { enable = true },
        },
      }

      require("lspconfig").sumneko_lua.setup(sumneko_lua_opts)
    end

    mason_lspconfig.setup_handlers({
      function(server)
        require("lspconfig")[server].setup({})
      end,
      ["als"] = setup_als,
      ["clangd"] = setup_clangd,
      ["jdtls"] = function() end,
      ["sumneko_lua"] = setup_sumneko_lua,
    })

    require("fidget").setup()

    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.clang_format,
        formatting.cmake_format,
        formatting.prettier,
        diagnostics.cpplint,
      },
    })
  end,
}
