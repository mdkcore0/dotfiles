-- nvim-lspconfig

local ok, lspconfig_ui = pcall(require, "lspconfig.ui.windows")
if not ok then
  return
end

lspconfig_ui.default_options = {
  border = "rounded",
}
