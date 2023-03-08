-- setup lualine.nvim

local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

lualine.setup({
  options = {
    theme = "auto",
  },
  tabline = {
    lualine_a = { "buffers" },
    lualine_b = { "filename" },
    lualine_z = { "tabs" },
  },
})
