-- Basic Neovim Configuration
-- This is the main entry point for Neovim configuration

-- Load core modules
require('core.options')
require('core.keymaps')
require('core.lsp')

-- Setup plugin manager (lazy.nvim)
require('core.lazy')

-- Load and apply Sema theme
vim.cmd('colorscheme sema')