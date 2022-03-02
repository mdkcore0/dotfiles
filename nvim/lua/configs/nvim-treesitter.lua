-- setup nvim-treesitter and nvim-treesitter-context

local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end
local ok, tscontext = pcall(require, "treesitter-context")
if not ok then
  return
end

treesitter.setup({
  highlight = {
    enable = true,
  },
  -- XXX https://github.com/nvim-lua/kickstart.nvim/blob/af239a5b8182f8aca36a62f3c88279e031edef56/init.lua#L151
  incremental_selection = {
    enable = true,
    keymaps = {
      -- TODO inc/dec?
      init_selection = "gni",
    },
  },
  indent = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = { enable = true },
    -- TODO maybe not so much useful?
    navigation = {
      enable = true,
      keymaps = {
        goto_next_usage = "gnn",
        goto_previous_usage = "gnp",
      },
    },
  },
})

tscontext.setup({
  -- toggle with :TSContextToggle (or add a keymap)
  enable = false,
})
