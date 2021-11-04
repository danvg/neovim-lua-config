local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local function replace_termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
end

local function tab(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(replace_termcodes("<C-n>"), "n")
  elseif luasnip.expand_or_jumpable() then
    vim.fn.feedkeys(replace_termcodes("<Plug>luasnip-expand-or-jump"), "")
  elseif check_back_space() then
    vim.fn.feedkeys(replace_termcodes("<tab>"), "n")
  else
    fallback()
  end
end

local function shift_tab(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(replace_termcodes("<C-p>"), "n")
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(replace_termcodes("<Plug>luasnip-jump-prev"), "")
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
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
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" })
    -- ["<Tab>"] = cmp.mapping(tab, { "i", "s" }),
    -- ["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s" })
  },
  sources = {
    { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" },
    { name = "nvim_lua" }, { name = "path" }
  }
})

cmp.setup.cmdline("/", { sources = { name = "buffer" } })

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({ name = "path" }, { name = "cmdline" })
})
