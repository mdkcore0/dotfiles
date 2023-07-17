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

-- ensure markdown_inline is also installed for markdown
local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not ok then
  return
end

local ft = "markdown_inline"
local installed = parsers.has_parser(parsers.ft_to_lang(ft))
if not installed then
  local treesitter = require("nvim-treesitter.install")
  treesitter.commands.TSUpdate["run"](ft)
end
