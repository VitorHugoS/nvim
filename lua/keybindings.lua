local keybindings = {}

local function register_buffer_keybindings()
  vim.keymap.set('n', '<leader>bn', function() vim.cmd("bn") end)
  vim.keymap.set('n', '<leader>bp', function() vim.cmd("bp") end)
  vim.keymap.set('n', '<leader>bd', function() vim.cmd("bd") end)
  -- vim.keymap.set('n', '<leader>bc', require('misc.buffers').buffer_choose)
end

local function register_fzf()
  --  local builtin = require('fzf-lua')
  vim.keymap.set("n", "<leader>,f", "<cmd>FzfLua files<cr>")
  vim.keymap.set("n", "<leader>,b", "<cmd>FzfLua buffers<cr>")
  vim.keymap.set("n", "<leader>,h", "<cmd>FzfLua helptags<cr>")
  vim.keymap.set("n", "<leader>,g", "<cmd>FzfLua live_grep<cr>")
  vim.keymap.set("n", "<leader>gr", "<cmd>FzfLua lsp_references<cr>")
  vim.keymap.set("n", "<leader>,gd", "<cmd>FzfLua lsp_document_diagnostics<cr>")
  vim.keymap.set("n", "<leader>,gf", "<cmd>FzfLua lgrep_curbuf<cr>")

  --vim.keymap.set('n', '<leader>,g', builtin.live_grep, {})
  --vim.keymap.set('n', '<leader>,b', builtin.buffers, {})
  --vim.keymap.set('n', '<leader>,h', builtin.help_tags, {})
end

local function register_bash_like_navigation_on_command_prompt()
  vim.api.nvim_set_keymap('c', '<C-A>', '<Home>', { noremap = true })
  vim.api.nvim_set_keymap('c', '<C-E>', '<End>', { noremap = true })
  vim.api.nvim_set_keymap('c', '<C-F>', '<Right>', { noremap = true })
  vim.api.nvim_set_keymap('c', '<C-B>', '<Left>', { noremap = true })
  vim.api.nvim_set_keymap('c', '<C-N>', '<Down>', { noremap = true })
  vim.api.nvim_set_keymap('c', '<C-P>', '<Up>', { noremap = true })
end

local function register_system_keybindings()
  --  vim.keymap.set('n', '<leader>sr', require('sys').reload_all)
end

function keybindings.register()
  --register_bash_like_navigation_on_command_prompt()
  register_system_keybindings()
  register_buffer_keybindings()
  register_fzf()
  --register_telescope()
  --register_paredit()
  --register_clojure()
end

return keybindings
