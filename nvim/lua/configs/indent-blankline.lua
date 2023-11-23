-- indent-blankline.nvim

local ok, ibl = pcall(require, "ibl")
if not ok then
  return
end

ibl.setup({
  indent = {
    char = "│",
  },
  scope = {
    include = {
      node_type = {
        ["*"] = { "*" },
      },
    },
  },
  exclude = {
    buftypes = { "terminal", "nofile" },
  },
})
