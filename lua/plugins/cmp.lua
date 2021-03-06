local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  vim.notify("cmp module not found!")
  return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
  vim.notify("lspkind module not found!")
  return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
  vim.notify("luasnip module not found!")
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
             :match("%s") == nil
end

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  formatting = { format = lspkind.cmp_format() },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ["<C-n>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ["<Up>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ["<Down>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select
    }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  },
  sources = {
    { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" },
    { name = "nvim_lua" }, { name = "path" }
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
})
