-- Stop lsp diagnostics from showing virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    signs = true
  })

local lspconfig = require("lspconfig")

-- npm i -g bash-language-server
lspconfig.bashls.setup {}

-- npm i -g typescript typescript-language-server
lspconfig.tsserver.setup {}

-- npm i -g vscode-css-languageserver-bin
lspconfig.cssls.setup {}

-- npm i -g pyright
lspconfig.pyright.setup {}

-- npm i -g vscode-json-languageserver
lspconfig.jsonls.setup {}

-- npm i -g emmet-ls
require("lspconfig/configs").emmet_ls = {
  default_config = {
    cmd = {"emmet-ls", "--stdio"},
    filetypes = {"html", "css"},
    root_dir = function() return vim.loop.cwd() end,
    settings = {}
  }
}
lspconfig.emmet_ls.setup {}

-- pacman -S clang
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

-- no need for hmtl server having emmet-ls and snippets working
-- npm i -g vscode-html-languageserver-bin
-- nvim_lsp.html.setup {}

vim.api.nvim_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gd", ":Telescope lsp_definitions<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gh", ":lua vim.lsp.buf.hover()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<space>rn", ":lua vim.lsp.buf.rename()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<c-p>", ":lua vim.lsp.diagnostic.goto_prev()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<c-n>", ":lua vim.lsp.diagnostic.goto_next()<CR>",
                        {noremap = true, silent = true})
