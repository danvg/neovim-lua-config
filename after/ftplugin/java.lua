require("config.lazy").load({
  "lsp_signature.nvim",
  "nvim-navic",
  "cmp-nvim-lsp",
  "nvim-jdtls",
  "nvim-dap",
})

local lsp_opts = require("config.lsp_opts")
lsp_opts.capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = lsp_opts.on_attach
lsp_opts.on_attach = function(client, bufnr)
  require("lsp_signature").on_attach()
  require("nvim-navic").attach(client, bufnr)
  require("jdtls.setup").add_commands()
  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  require("jdtls.dap").setup_dap_main_class_configs()
  on_attach(client, bufnr)
end

local os_name
if vim.fn.has("win32") then
  os_name = "win"
elseif vim.fn.has("linux") then
  os_name = "linux"
elseif vim.fn.has("mac") then
  os_name = "mac"
else
  vim.notify("Unsupported OS")
  return
end

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local jdtls_launcher_path =
  vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_config_path = jdtls_path .. "/config_" .. os_name
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_data_path = os.getenv("HOME") .. "/.cache/jdtls/" .. project_name

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
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

local config = {
  cmd = {
    os.getenv("JAVA_HOME") .. "/bin/java",
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
    jdtls_launcher_path,
    "-configuration",
    jdtls_config_path,
    "-data",
    jdtls_data_path,
  },
  root_dir = require("jdtls.setup").find_root({
    ".git",
    "build.gradle",
    "pom.xml",
  }),
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-11",
            path = vim.fn.glob(
              os.getenv("HOME") .. "/.cache/java/jdk/openjdk_11*"
            ),
          },
          {
            name = "JavaSE-18",
            path = vim.fn.glob(
              os.getenv("HOME") .. "/.cache/java/jdk/openjdk_18*"
            ),
          },
          {
            name = "JavaSE-19",
            path = vim.fn.glob(
              os.getenv("HOME") .. "/.cache/java/jdk/openjdk_19*"
            ),
          },
        },
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
            enabled = "all", -- literals, all, none
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
          "org.junit.jupiter.api.Assertions.*",
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
  on_attach = lsp_opts.on_attach,
  capabilities = lsp_opts.capabilities,
  flags = vim.tbl_extend(
    "force",
    lsp_opts.flags,
    { allow_incremental_sync = true }
  ),
  handlers = lsp_opts.handlers,
}

config.on_init = function(client, _)
  client.notify(
    "workspace/didChangeConfigurations",
    { settings = config.settings }
  )
end

require("jdtls").start_or_attach(config)

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("JavaFormatGroup", { clear = true }),
  pattern = { "*.java" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_user_command("JdtTestClass", function()
  require("jdtls.dap").test_class()
end, { bang = true })

vim.api.nvim_create_user_command("JdtTestNearestMethod", function()
  require("jdtls.dap").test_nearest_method()
end, { bang = true })
