-- nvim-autopairs

local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end
local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

autopairs.setup({
  check_ts = true,
  enable_check_bracket_line = false,
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
