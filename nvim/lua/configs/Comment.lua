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
    line = "<leader>c<space>",
    block = "<leader>v<space>",
  },
  opleader = {
    line = "<leader>c<space>",
    block = "<leader>v<space>",
  },
})

-- normal-mode linewise yank
vim.keymap.set("n", "<leader>cy", "yy<Plug>(comment_toggle_linewise_current)")
-- normal-mode blockwise yank
vim.keymap.set("n", "<leader>vy", "yy<Plug>(comment_toggle_blockwise_current)")
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
