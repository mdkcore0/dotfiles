vim.loader.enable()

vim.g.mapleader = "f"
vim.g.maplocalleader = "f"

vim.o.updatetime = 250

vim.wo.number = true
vim.o.cursorline = true

vim.o.completeopt = "menuone,noselect"
vim.o.undofile = true
vim.o.splitright = true
vim.o.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true

vim.o.mouse = nil

-- restore last cursor position
vim.cmd([[
  autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

-- lsp UI configuration
vim.cmd([[
  autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="line"})
]])

local border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = border,
})
vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  update_in_insert = true,
  float = {
    source = "always",
    border = "rounded",
  },
})

-- let the fun begin!
require("plugins")
