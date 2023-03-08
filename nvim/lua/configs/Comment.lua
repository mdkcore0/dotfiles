-- numToStr/Comment.nvim

local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

comment.setup({
  -- disable all mappings and customize them below
  mappings = {
    basic = true,
    extra = false,
  },
  toggler = {
    line = '<leader>c<space>',
    block = '<leader>v<space>',
   },
  opleader = {
    line = '<leader>c<space>',
    block = '<leader>v<space>',
    },
})

-- normal-mode linewise yank
vim.api.nvim_set_keymap(
  "n",
  "<leader>cy",
  [[<cmd>yank<CR><cmd>lua require('Comment.api').call('toggle.linewise.current')<CR>g@$]],
  { noremap = true }
)
-- normal-mode blockwise yank
vim.api.nvim_set_keymap(
  "n",
  "<leader>vy",
  [[<cmd>yank<CR><cmd>lua require('Comment.api').call('toggle.blockwise.current')<CR>g@$]],
  { noremap = true }
)
-- visual-mode linewise yank
vim.api.nvim_set_keymap(
  "x",
  "<leader>cy",
  [[<ESC><cmd>'<,'>yank*<CR><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>]],
  { noremap = true }
)
-- visual-mode blockwise yank
vim.api.nvim_set_keymap(
  "x",
  "<leader>vy",
  [[<ESC><cmd>'<,'>yank*<CR><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>]],
  { noremap = true }
)
