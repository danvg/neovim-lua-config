-- Stop lsp diagnostics from showing virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false,
    underline = false,
    signs = true
  })

local lspconfig = require("lspconfig")

-- npm i -u typescript typescript-language-server
lspconfig.tsserver.setup {}

-- npm i -u vscode-html-languageserver-bin
lspconfig.html.setup {}

-- npm i -u typescript
-- npm i -u @angular/language-service
lspconfig.angularls.setup {}

-- npm i -u vscode-css-languageserver-bin
lspconfig.cssls.setup {}

-- npm i -u vscode-json-languageserver
lspconfig.jsonls.setup {}

-- npm i -u pyright
lspconfig.pyright.setup {}

-- pip install --user cmake-language-server
lspconfig.cmake.setup {}

-- pacman -S clang / scoop install llvm
lspconfig.clangd.setup {}

-- npm i -u vim-language-server
lspconfig.vimls.setup {}

------------------------------------------------------------------------------
-- Manually installed
------------------------------------------------------------------------------

local ls_install_root = vim.fn.stdpath("data") .. "/language_servers"

-- install instructions (Linux):
-- git clone https://github.com/sumneko/lua-language-server ~/.local/share/nvim/language_servers/sumneko_lua
-- cd ~/.local/share/nvim/language_servers/sumneko_lua
-- git submodule update --init --recursive
-- cd 3rd/luamake
-- compile/install.sh
-- cd ../..
-- ./3rd/luamake/luamake rebuild

if vim.fn.isdirectory(ls_install_root .. "/sumneko_lua") then

  local luaos = vim.loop.os_uname().sysname
  if luaos == "Windows_NT" then luaos = "Windows" end

  local luapath = ls_install_root .. "/sumneko_lua"
  local luabin = luapath .. "/bin/" .. luaos .. "/lua-language-server"

  local diagnostic_globals = { "vim", "use" }

  local workspace_libraries = {
    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
  }

  if vim.fn.filereadable("/usr/share/xsessions/awesome.desktop") then
    -- awesome wm globals
    table.insert(diagnostic_globals, "awesome")
    table.insert(diagnostic_globals, "client")
    table.insert(diagnostic_globals, "root")
    table.insert(diagnostic_globals, "screen")
    -- awesome wm libs
    workspace_libraries["/usr/share/awesome/lib"] = true
  end

  lspconfig.sumneko_lua.setup {
    cmd = { luabin, "-E", luapath .. "/main.lua" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua
          -- you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";")
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = diagnostic_globals
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = workspace_libraries,
          maxPreload = 10000
        },
        telemetry = { enable = false }
      }
    }
  }

end

-- ada language server, at the moment the only way to get
-- it is to compile it (very hard) or take it from the
-- vscode plugin, only the executable ada_language_server
-- is needed
if vim.fn.isdirectory(ls_install_root .. "/als") then

  lspconfig.als.setup {
    cmd = { ls_install_root .. "/als/ada_language_server" },
    settings = {
      ada = {
        projectFile = "project.gpr",
        scenarioVariables = {},
        enableDiagnostics = true,
        defaultCharset = "utf-8",
        renameInComments = true
      }
    }
  }

end

