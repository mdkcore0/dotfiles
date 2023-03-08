-- setup nvim-cmp and luasnip

local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end
local ok, luasnip = pcall(require, "luasnip")
if not ok then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
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
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
    { name = "buffer" },
    { name = "path", options = {
      trigger_characters = { "/" },
    } },
  }),
})

-- setup buffer source for '/'
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
  mapping = cmp.mapping.preset.cmdline(),
})

-- setup cmp-path and cmp-cmdline for ':'
cmp.setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.cmdline(),
})

require("luasnip.loaders.from_vscode").lazy_load()
