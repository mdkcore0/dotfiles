-- indent-blankline.nvim

local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
  return
end

indent_blankline.setup({
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  buftype_exclude = { "terminal", "nofile" },
})
