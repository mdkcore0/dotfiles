-- theme and colors

local ok, base16 = pcall(require, "base16-colorscheme")
if not ok then
  return
end

base16.with_config({
  telescope = false,
})

vim.cmd("colorscheme base16-" .. vim.env.BASE16_THEME)
