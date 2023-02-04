---@diagnostic disable: missing-parameter

local jdtls = require("jdtls")
local mason_reg = require("mason-registry")

if not mason_reg.has_package("jdtls") then
  vim.notify("Mason jdtls package missing, skipping lsp setup")
  return
end

local has_debugger = false
local bundles = {}

if
  mason_reg.has_package("java-test")
  and mason_reg.has_package("java-debug-adapter")
then
  vim.notify("Java debugger found")
  has_debugger = true

  bundles = {
    vim.fn.glob(
      vim.fn.stdpath("data")
        .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
      true
    ),
  }

  vim.list_extend(
    bundles,
    vim.split(
      vim.fn.glob(
        vim.fn.stdpath("data")
          .. "/mason/packages/java-test/extension/server/*.jar",
        true
      ),
      "\n"
    )
  )
else
  vim.notify("Missing Java debugger")
end

local lsp_opts = require("config.lsp")
local opts = vim.tbl_extend("force", lsp_opts, {})

local default_on_attach = opts.on_attach
opts.on_attach = function(client, bufnr)
  require("jdtls.setup").add_commands()

  if has_debugger then
    vim.cmd("SetupDap")

    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()

    vim.api.nvim_create_user_command("JdtTestClass", function()
      require("jdtls.dap").test_class()
    end, { bang = true })

    vim.api.nvim_create_user_command("JdtTestNearestMethod", function()
      require("jdtls.dap").test_nearest_method()
    end, { bang = true })
  end

  default_on_attach(client, bufnr)
end

opts.capabilities = require("cmp_nvim_lsp").default_capabilities()

local os_name
if vim.fn.has("mac") == 1 then
  os_name = "mac"
elseif vim.fn.has("unix") == 1 then
  os_name = "linux"
elseif vim.fn.has("win32") == 1 then
  os_name = "win"
else
  vim.notify("Unsupported OS")
end

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local equinox_path =
  vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = jdtls_path .. "/config_" .. os_name
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_path = vim.env.HOME .. "/.cache/jdtls/workspace"
local data_path = workspace_path .. "/" .. project_name
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

local java_exe
if vim.env.JAVA_HOME ~= nil then
  java_exe = vim.env.JAVA_HOME .. "/bin/java"
else
  java_exe = "java"
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    java_exe,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    equinox_path,
    "-configuration",
    config_path,
    "-data",
    data_path,
  },
  root_dir = require("jdtls.setup").find_root(root_markers),
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = "literals", -- literals, all, none
          },
        },
        format = {
          enabled = true,
        },
      },
      signatureHelp = { enabled = true },
      completion = {
        filteredTypes = {
          "java.awt.List",
          "com.sun.*",
        },
        favoriteStaticMembers = {
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
        },
      },
      contentProvider = { preferred = "fernflower" },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  },
  on_attach = opts.on_attach,
  capabilities = opts.capabilities,
  flags = vim.tbl_extend(
    "force",
    opts.flags,
    { allow_incremental_sync = true }
  ),
  handlers = opts.handlers,
}

config.on_init = function(client, _)
  client.notify(
    "workspace/didChangeConfigurations",
    { settings = config.settings }
  )
end

jdtls.start_or_attach(config)
