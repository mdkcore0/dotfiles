-- setup lualine.nvim

local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

lualine.setup({
  options = {
    theme = "auto",
    globalstatus = true,
  },
  tabline = {
    lualine_a = {
      { "buffers", show_filename_only = false },
    },
    lualine_b = {
      { "filename", path = 1 },
    },
    lualine_z = { "tabs" },
  },
  sections = {
    lualine_b = {
      { "b:gitsigns_head", icon = "" },
      { "diff", source = diff_source },
    },
    lualine_c = {
      { "filename", path = 1 },
    },
  },
})
