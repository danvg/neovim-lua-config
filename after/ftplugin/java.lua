if not packer_plugins["lsp_signature.nvim"].loaded then
  vim.cmd([[packadd lsp_signature.nvim]])
end

if not packer_plugins["nvim-navic"].loaded then
  vim.cmd([[packadd nvim-navic]])
end

if not packer_plugins["cmp-nvim-lsp"].loaded then
  vim.cmd([[packadd cmp-nvim-lsp]])
end

if not packer_plugins["nvim-jdtls"].loaded then
  vim.cmd([[packadd nvim-jdtls]])
end

local on_attach = function(client, bufnr)
  require("lsp_signature").on_attach()
  require("nvim-navic").attach(client, bufnr)
  require("jdtls.setup").add_commands()

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
  init_options = {
    bundles = {},
    extendedClientCapabilities = extendedClientCapabilities,
  },
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  flags = { debounce_text_changes = 150, allow_incremental_sync = true },
}

require("jdtls").start_or_attach(config)

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("JavaFormatGroup", { clear = true }),
  pattern = { "*.java" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
