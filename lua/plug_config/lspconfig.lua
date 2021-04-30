-- Stop lsp diagnostics from showing virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text      = false,
    update_in_insert  = false,
    underline         = false,
    signs             = true
  })

local lspconfig = require("lspconfig")

-- npm i -g typescript typescript-language-server
lspconfig.tsserver.setup {}

-- npm i -g vscode-html-languageserver-bin
lspconfig.html.setup {}

-- npm i -g vscode-css-languageserver-bin
lspconfig.cssls.setup {}

-- npm i -g vscode-json-languageserver
lspconfig.jsonls.setup {}

-- npm i -g pyright
lspconfig.pyright.setup {}

-- pip install --user cmake-language-server
lspconfig.cmake.setup {}

-- pacman -S clang / scoop install llvm
lspconfig.clangd.setup {}

-- lua  https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
-- install instructions:
-- git clone https://github.com/sumneko/lua-language-server $HOME/.local/share/nvim/lua/sumneko_lua
-- cd ~/.local/share/nvim/lua/sumneko_lua
-- git submodule update --init --recursive
-- cd 3rd/luamake
-- compile/install.sh
-- cd ../..
-- ./3rd/luamake/luamake rebuild

local luapath = ""
local luabin = ""

if vim.loop.os_uname().sysname == "Windows_NT" then
  luapath = os.getenv("USERPROFILE") .. "/language_servers/lua-language-server"
  luabin = luapath .. "/bin/Windows/lua-language-server.exe"
else
  luapath = "/home/" .. os.getenv("USER") ..
              "/.local/share/nvim/lua/sumneko_lua"
  luabin = luapath .. "/bin/Linux/lua-language-server"
end

lspconfig.sumneko_lua.setup {
  cmd = {luabin, "-E", luapath .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim", "use"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
        },
        maxPreload = 10000
      },
      telemetry = {enable = false}
    }
  }
}
