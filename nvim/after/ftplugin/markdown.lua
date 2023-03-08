--[[
mixing [1] and [2] on here
[1] https://arcticicestudio.github.io/styleguide-markdown/
[2] https://google.github.io/styleguide/docguide/style.html

"avoid using a character limit per line for flowing text, but try to use a maximum line length of 120 characters
(including whitespaces) for all other document elements"
https://arcticicestudio.github.io/styleguide-markdown/rules/whitespace.html#maximum-line-length.
--]]
vim.o.colorcolumn = "120"
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- update markdown parser
local ok, treesitter = pcall(require, "nvim-treesitter.install")
if not ok then
  return
end
treesitter.commands.TSUpdate["run"]("markdown")
treesitter.commands.TSUpdate["run"]("markdown_inline")

-- additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setup markdown server
require("lspconfig").marksman.setup({
  on_attach = require("configs.keybindings").lsp_keybindings,
  capabilities = capabilities,
})
require("lspconfig").marksman.manager.try_add_wrapper()
