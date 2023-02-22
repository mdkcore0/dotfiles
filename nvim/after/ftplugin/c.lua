-- update c/c++ parsers
local ok, treesitter = pcall(require, "nvim-treesitter.install")
if not ok then
  return
end
treesitter.commands.TSUpdate["run"]("c", "cpp")

-- additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup c/c++ server
require("lspconfig").clangd.setup({
  on_attach = require("configs.keybindings").lsp_keybindings,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--completion-style=detailed",
    "--suggest-missing-includes",
  },
})
require("lspconfig").clangd.manager.try_add_wrapper()
