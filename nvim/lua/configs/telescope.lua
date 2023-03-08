-- nvim-telescope/telescope.nvim

local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end
local ok, _ = pcall(require, "luasnip")
if not ok then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = "select_horizontal",
        ["<ESC>"] = require("telescope.actions").close,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  },
  pickers = {
    grep_string = {
      theme = "ivy",
    },
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      sort_mru = true,
      show_all_buffers = false,
      ignore_current_buffer = true,
      layout_config = {
        width = 0.5,
        height = 0.5,
      },
    },
    current_buffer_fuzzy_find = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    diagnostics = {
      theme = "ivy",
    },
  },
})

telescope.load_extension("fzf")

-- cursor on word
vim.api.nvim_set_keymap(
  "n",
  "<leader>*",
  [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>i",
  [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
  { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>b", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>/",
  [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
  { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>?", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>o",
  [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],
  { noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>g", [[<cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true })
-- diagnostics on current buffer
vim.api.nvim_set_keymap(
  "n",
  "<leader>d",
  [[<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0})<CR>]],
  { noremap = true }
)
-- diagnostics on all buffers
vim.api.nvim_set_keymap(
  "n",
  "<leader>D",
  [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]],
  { noremap = true }
)
-- cursor on word
vim.api.nvim_set_keymap(
  "n",
  "<leader>lr",
  [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
  { noremap = true }
)
