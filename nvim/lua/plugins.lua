-- bootstrap packer.nvim
local install_path = vim.fn.stdpath('data')
    .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.execute(
    '!git clone --depth 1 https://github.com/wbthomason/packer.nvim '
    .. install_path
  )
end


-- run :PackerCompile whenever this file is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


-- plugins \o/
packer = require('packer')
packer.startup({function()
  -- packer.nvim itself
  use 'wbthomason/packer.nvim'

  -- LSP things
  use 'neovim/nvim-lspconfig'

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    }
  }

  -- parsing and highlight
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'romgrk/nvim-treesitter-context',
    },
    run = ':TSUpdate',
  }

  -- statusline and tabline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- git stuff
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim', opt = true}
  }

  -- tmux integration (navigation, copy, ...)
  use 'aserowy/tmux.nvim'

  -- moving around
  use 'phaazon/hop.nvim'

  -- autopair
  use 'windwp/nvim-autopairs'

  -- indentation
  use 'lukas-reineke/indent-blankline.nvim'

  -- misc
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    }
  }

  -- comment
  use 'numToStr/Comment.nvim'

  -- theme
  use 'RRethy/nvim-base16'

  -- this goes after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'rounded'})
    end,
    prompt_border = 'rounded',
  }
}})


-- setup nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- XXX move mappings to another module
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'nvim_lsp_signature_help'},
    {name = 'buffer'},
    {name = 'path',
      options = {
        trigger_characters = {'/'}
      },
    },
  })
})

-- setup buffer source for '/'
cmp.setup.cmdline('/', {
  sources = {
    {name = 'buffer'}
  }
})

-- setup cmp-path and cmp-cmdline for ':'
cmp.setup.cmdline(':', {
  sources = {
    {name = 'cmdline'},
    {name = 'path'},
  }
})

require("luasnip.loaders.from_vscode").lazy_load()


-- setup nvim-treesitter
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
    },
    -- maybe not so much useful?
    navigation = {
      enable = true,
      keymaps = {
        goto_next_usage = 'gnn',
        goto_previous_usage = 'gnp',
      },
    },
  },
})


-- setup lualine.nvim
require('lualine').setup({
  options = {
    theme = 'auto'
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {'filename'},
    lualine_z = {'tabs'},
  },
})


-- gitsigns
require('gitsigns').setup({
  signs = {
    add = {hl = 'GitGutterAdd', numhl='GitGutterAdd', text = '│'},
    change = {hl = 'GitGutterChange', numhl='GitGutterChange', text = '│'},
    delete = {hl = 'GitGutterDelete', numhl='GitGutterDelete', text = '_'},
    topdelete = {hl = 'GitGutterDelete', numhl='GitGutterDelete', text = '‾'},
    changedelete = {hl = 'GitGutterChange', numhl='GitGutterChange', text = '~'},
  },
  numhl = true,
})
vim.api.nvim_set_keymap(
  'n',
  ']c',
  [[<cmd>Gitsigns next_hunk<CR>]],
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'n',
  '[c',
  [[<cmd>Gitsigns prev_hunk<CR>]],
  {noremap = true}
)


-- tmux.nvim
require('tmux').setup({
  copy_sync = {
    enable = true,
    redirect_to_clipboard = true,
  },
  navigation = {
    enable_default_keybindings = true,
    persist_zoom = true,
  },
})


-- hop.nvim
require('hop').setup()
vim.api.nvim_set_keymap(
  'n',
  '<leader>f',
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>F',
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  'v',
  '<leader>f',
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.AFTER_CURSOR, inclusive_jump = true})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  'v',
  '<leader>F',
  [[<cmd>lua require('hop').hint_char1({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, inclusive_jump = true})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>j',
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.AFTER_CURSOR})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>k',
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.BEFORE_CURSOR})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  'v',
  '<leader>j',
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.AFTER_CURSOR, inclusive_jump = true})<CR>]],
  {}
)
vim.api.nvim_set_keymap(
  'v',
  '<leader>k',
  [[<cmd>lua require('hop').hint_lines({direction = require('hop.hint').HintDirection.BEFORE_CURSOR, inclusive_jump = true})<CR>]],
  {}
)


-- nvim-autopairs
require('nvim-autopairs').setup({
  check_ts = true,
  enable_check_bracket_line = false,
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))


-- indent-blankline.nvim
require('indent_blankline').setup({
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  buftype_exclude = {'terminal', 'nofile'},
})


-- nvim-telescope/telescope.nvim
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = "select_horizontal",
        ["<ESC>"] = require('telescope.actions').close,
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
require('telescope').load_extension('fzf')
-- cursor on word
vim.api.nvim_set_keymap(
  'n',
  '<leader>*',
  [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>i',
  [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>b',
  [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>/',
  [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>?',
  [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>o',
  [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>g',
  [[<cmd>lua require('telescope.builtin').git_files()<CR>]],
  {noremap = true}
)
-- diagnostics on current buffer
vim.api.nvim_set_keymap(
  'n',
  '<leader>d',
  [[<cmd>lua require('telescope.builtin').diagnostics({bufnr = 0})<CR>]],
  {noremap = true}
)
-- diagnostics on all buffers
vim.api.nvim_set_keymap(
  'n',
  '<leader>D',
  [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]],
  {noremap = true}
)
-- cursor on word
vim.api.nvim_set_keymap(
  'n',
  '<leader>lr',
  [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
  {noremap = true}
)


-- numToStr/Comment.nvim
require('Comment').setup({
  -- disable all mappings and customize them below
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  },
})
-- normal-mode linewise
vim.api.nvim_set_keymap(
  'n',
  '<leader>c<space>',
  [[<cmd>lua require('Comment.api').call('toggle_current_linewise_op')<CR>g@$]],
  {noremap = true}
)
-- normal-mode linewise (yank)
vim.api.nvim_set_keymap(
  'n',
  '<leader>cy',
  [[<cmd>yank<CR><cmd>lua require('Comment.api').call('toggle_current_linewise_op')<CR>g@$]],
  {noremap = true}
)
-- normal-mode blockwise
vim.api.nvim_set_keymap(
  'n',
  '<leader>v<space>',
  [[<cmd>lua require('Comment.api').call('toggle_current_blockwise_op')<CR>g@$]],
  {noremap = true}
)
-- normal-mode blockwise (yank)
vim.api.nvim_set_keymap(
  'n',
  '<leader>vy',
  [[<cmd>yank<CR><cmd>lua require('Comment.api').call('toggle_current_blockwise_op')<CR>g@$]],
  {noremap = true}
)
-- visual-mode linewise
vim.api.nvim_set_keymap(
  'x',
  '<leader>c<space>',
  [[<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>]],
  {noremap = true}
)
-- visual-mode linewise (yank)
vim.api.nvim_set_keymap(
  'x',
  '<leader>cy',
  [[<ESC><cmd>'<,'>yank*<CR><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>]],
  {noremap = true}
)
-- visual-mode blockwise
vim.api.nvim_set_keymap(
  'x',
  '<leader>v<space>',
  [[<ESC><cmd>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>]],
  {noremap = true}
)
-- visual-mode blockwise (yank)
vim.api.nvim_set_keymap(
  'x',
  '<leader>vy',
  [[<ESC><cmd>'<,'>yank*<CR><cmd>lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>]],
  {noremap = true}
)


-- nvim-treesitter-context
require('treesitter-context').setup({
  -- toggle with :TSContextToggle (or add a keymap)
  enable = false,
})


vim.cmd('colorscheme base16-' .. vim.env.BASE16_THEME)
