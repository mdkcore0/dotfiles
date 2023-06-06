-- nvim-lspconfig

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

require("lspconfig.ui.windows").default_options = {
  border = "rounded",
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- XXX: based on https://git.sr.ht/~whynothugo/dotfiles/tree/main/item/home/.config/nvim/lua/lsp.lua
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  marksman = {},
  clangd = {
    cmd = {
      "clangd",
      "--completion-style=detailed",
      "--suggest-missing-includes",
    },
  },
}

for server, config in pairs(servers) do
  if config.sandbox ~= nil then
    config.cmd = { "false" }
    config.before_init = function(params)
      params.processId = vim.NIL
    end
  end

  config.on_attach = require("configs.keybindings").lsp_keybindings
  config.capabilities = capabilities

  lspconfig[server].setup(config)
end
