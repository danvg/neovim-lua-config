-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(_, bufnr)
  local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
  if lsp_signature_ok then lsp_signature.on_attach() end

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>wa",
                 "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wr",
                 "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wl",
                 "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                 opts)
  buf_set_keymap("n", "<leader>ds",
                 "<cmd>lua print(vim.inspect(vim.lsp.buf.document_symbol()))<CR>",
                 opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>",
                 opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",
                 opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(
                           base_capabilities)

local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if lsp_installer_ok then
  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = custom_on_attach,
      capabilities = cmp_capabilities,
      flags = { debounce_text_changes = 150 }
    }

    -- setup C/C++ language server
    if server.name == "clangd" then
      opts.cmd = {
        "clangd", "--enable-config", "--background-index",
        "--pch-storage=memory", "--all-scopes-completion",
        "--header-insertion=iwyu", "--fallback-style=Google", "--clang-tidy",
        "--compile-commands-dir=build"
      }
    end

    -- setup lua language server
    if server.name == "sumneko_lua" then
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      opts.settings = {
        Lua = {
          runtime = { version = "LuaJIT", path = runtime_path },
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false }
        }
      }
    end

    server:setup(opts)
    vim.cmd [[do User LspAttachBuffers]]
  end)
end

vim.cmd [[
  :command! LspFormat :lua vim.lsp.buf.formatting()<CR>
  :command! LspSwitchSourceHeader :lua require("plugins.lsp_ext").switch_source_header()<CR>
  :command! LspPeekDeclaration :lua require("plugins.lsp_ext").peek_declaration()<CR>
  :command! LspPeekDefinition :lua require("plugins.lsp_ext").peek_definition()<CR>
]]

-- Setup jdtls
local jdtls_ok, jdtls = pcall(require, "jdtls")
if jdtls_ok then
  local jdtls_on_attach = function(client, bufnr)
    custom_on_attach(client, bufnr)
    jdtls.setup.add_commands()
  end

  local jdtls_mk_config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.workspace.configuration = true
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
      flags = { allow_incremental_sync = true },
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.diagnostic
          .publishDiagnostics
      },
      capabilities = capabilities,
      on_attach = jdtls_on_attach
    }
  end

  _G.jdtls_start = function()
    local java_bin = vim.env.JAVA_HOME .. "/bin/java"
    local jdtls_root = vim.env.HOME .. "/.local/share/lang/servers/jdtls"
    local lombok_jar = jdtls_root .. "/lombok.jar"
    local plugin_jar = jdtls_root ..
                         "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"

    local config_dir
    if vim.fn.has("win32") then
      config_dir = jdtls_root .. "/config_win"
    elseif vim.fn.has("unix") then
      config_dir = jdtls_root .. "/config_linux"
    elseif vim.fn.has("mac") then
      config_dir = jdtls_root .. "/config_mac"
    else
      vim.notify("JDTLS: Unsupported platform!")
      return
    end

    local workspace_dir = vim.env.HOME .. "/workspace"

    local extendedClientCapabilities = jdtls.extendedClientCapabilities;
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

    local config = jdtls_mk_config()

    config.init_options = {
      extendedClientCapabilities = extendedClientCapabilities
    }

    config.cmd = {
      java_bin, "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "-Xmx2G",
      "-javaagent:" .. lombok_jar, "--add-modules=ALL-SYSTEM", "--add-opens",
      "java.base/java.util=ALL-UNNAMED", "--add-opens",
      "java.base/java.lang=ALL-UNNAMED", "-jar", plugin_jar, "-configuration",
      config_dir, "-data", workspace_dir
    }

    config.root_dir = jdtls.setup.find_root({
      ".git", "mvnw", "gradlew", "pom.xml", ".project"
    })

    config.flags = { server_side_fuzzy_completion = true }

    config.settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
        completion = {
          favoriteStaticMembers = {
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse"
          }
        },
        sources = {
          organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 }
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
          }
        },
        configuration = {
          runtimes = { { name = "JavaSE-16", path = vim.env.JAVA_HOME } }
        }
      }
    }

    jdtls.start_or_attach(config)
  end

  vim.cmd [[
  augroup jdtls
    au!
    au FileType java lua _G.jdtls_start()
  augroup end
  ]]
end
