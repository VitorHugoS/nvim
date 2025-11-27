-- Get the current package path
vim.g.lsp_no_default_bindings = true
local package_path = package.path

local config_dir = vim.fn.stdpath('config')

-- Add the path to the 'nvim' directory to the package path
package.path = config_dir .. "/?.lua;" .. package_path

-- matchparen may cause issues with clojure
vim.g.loaded_matchparen = 1

-- Basic editor configuration
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.g.lsp_no_default_bindings = true
--vim.opt.colorcolumn = "80"


-- Leader key
vim.g.mapleader = ','
--
-- enable x clipboard integration
vim.opt.clipboard = "unnamedplus"

Packages = require('packages')

Packages.install('https://github.com/editorconfig/editorconfig-vim')
Packages.install('https://github.com/neovim/nvim-lspconfig')
Packages.install('https://github.com/nvim-lua/plenary.nvim')
Packages.install('https://github.com/ibhagwan/fzf-lua')
Packages.install('https://github.com/mason-org/mason.nvim')
Packages.install('https://github.com/mason-org/mason-lspconfig.nvim')
--packages.install('https://github.com/nvim-telescope/telescope.nvim')
--Packages.install('https://git.sr.ht/~johnnyrichard/olang.vim')

vim.cmd('colorscheme torte')
vim.cmd('autocmd CompleteDone * pclose')

--require('diagnostic').setup()
require('mason').setup()
require("mason-lspconfig").setup()
require("fzf-lua").lsp_code_actions({ sync = true })
require("fzf-lua").register_ui_select(function(_, items)
  local min_h, max_h = 0.15, 0.70
  local h = (#items + 4) / vim.o.lines
  if h < min_h then
    h = min_h
  elseif h > max_h then
    h = max_h
  end
  return { winopts = { height = h, width = 0.60, row = 0.40 } }
end)
-- Keybindings

require('keybindings').register()

require('lsp').setup()
--require('languages.clojure')
