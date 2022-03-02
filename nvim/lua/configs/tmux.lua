-- tmux.nvim

local ok, tmux = pcall(require, "tmux")
if not ok then
  return
end

tmux.setup({
  copy_sync = {
    enable = true,
    redirect_to_clipboard = true,
  },
  navigation = {
    enable_default_keybindings = true,
    persist_zoom = true,
  },
})
