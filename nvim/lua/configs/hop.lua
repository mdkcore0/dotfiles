-- hop.nvim

local ok, hop = pcall(require, "hop")
if not ok then
  return
end

hop.setup()
vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>F",
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR})<CR>]],
  {}
)
-- luacheck: no max line length
vim.api.nvim_set_keymap(
  "v",
  "<leader>f",
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, inclusive_jump = true})<CR>]],
  {}
)
-- luacheck: no max line length
vim.api.nvim_set_keymap(
  "v",
  "<leader>F",
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, inclusive_jump = true})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>j",
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.AFTER_CURSOR})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>k",
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.BEFORE_CURSOR})<CR>]],
  {}
)
-- luacheck: no max line length
vim.api.nvim_set_keymap(
  "v",
  "<leader>j",
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.AFTER_CURSOR, inclusive_jump = true})<CR>]],
  {}
)
-- luacheck: no max line length
vim.api.nvim_set_keymap(
  "v",
  "<leader>k",
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, inclusive_jump = true})<CR>]],
  {}
)
