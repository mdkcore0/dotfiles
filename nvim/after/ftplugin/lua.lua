vim.o.colorcolumn = "120"
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- update lua parser
local ok, treesitter = pcall(require, "nvim-treesitter.install")
if not ok then
  return
end
treesitter.commands.TSUpdate["run"]("lua")

-- additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- setup c/c++ server
require("lspconfig").lua_ls.setup({
  on_attach = require("configs.keybindings").lsp_keybindings,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
require("lspconfig").lua_ls.manager.try_add_wrapper()
