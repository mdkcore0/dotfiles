-- bootstrap packer.nvim
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.execute("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
  -- https://github.com/wbthomason/packer.nvim/issues/750
  vim.cmd("packadd packer.nvim")
end

-- run :PackerCompile whenever this file is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- plugins \o/
local packer = require("packer")
packer.startup({
  function(use)
    -- packer.nvim itself
    use("wbthomason/packer.nvim")

    -- LSP things
    -- XXX https://github.com/nvim-lua/kickstart.nvim/blob/af239a5b8182f8aca36a62f3c88279e031edef56/init.lua#L204
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("configs.nvim-lspconfig")
      end,
    })

    use({
      "j-hui/fidget.nvim",
      tag = "legacy",
      config = function()
        require("fidget").setup()
      end,
    })

    -- completion
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
      config = function()
        require("configs.nvim-cmp")
      end,
    })

    -- parsing and highlight
    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-context",
      },
      run = ":TSUpdate",
      config = function()
        require("configs.nvim-treesitter")
      end,
    })

    -- statusline and tabline
    use({
      "nvim-lualine/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("configs.lualine")
      end,
    })

    -- git stuff
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("configs.gitsigns")
      end,
    })

    -- tmux integration (navigation, copy, ...)
    use({
      "aserowy/tmux.nvim",
      config = function()
        require("configs.tmux")
      end,
    })

    -- moving around
    use({
      "smoka7/hop.nvim",
      config = function()
        require("configs.hop")
      end,
    })

    -- autopair
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("configs.nvim-autopairs")
      end,
    })

    -- indentation
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("configs.indent-blankline")
      end,
    })

    -- misc
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
      config = function()
        require("configs.telescope")
      end,
    })

    -- comment
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("configs.Comment")
      end,
    })

    -- theme
    use({
      "RRethy/nvim-base16",
      config = function()
        require("configs.colors")
      end,
    })

    -- bootstraping
    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
      prompt_border = "rounded",
    },
  },
})
