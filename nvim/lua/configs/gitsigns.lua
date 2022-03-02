-- gitsigns

local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = "GitGutterAdd", numhl = "GitGutterAdd", text = "│" },
    change = { hl = "GitGutterChange", numhl = "GitGutterChange", text = "│" },
    delete = { hl = "GitGutterDelete", numhl = "GitGutterDelete", text = "_" },
    topdelete = { hl = "GitGutterDelete", numhl = "GitGutterDelete", text = "‾" },
    changedelete = { hl = "GitGutterChange", numhl = "GitGutterChange", text = "~" },
  },
  numhl = true,
  preview_config = {
    border = "rounded",
  },
})
vim.api.nvim_set_keymap("n", "]c", [[<cmd>Gitsigns next_hunk<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "[c", [[<cmd>Gitsigns prev_hunk<CR>]], { noremap = true })
