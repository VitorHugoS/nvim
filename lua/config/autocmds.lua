vim.api.nvim_create_autocmd('FileType', {
  pattern = 'clojure',
  callback = function()
    -- !!! ALTERE A LINHA ABAIXO PARA USAR O NOME CORRETO DO SEU PLUGIN !!!
    local cmp = require('blink.cmp')

    vim.keymap.set('i', '/', function()
      -- 1. Insere o caractere '/' no buffer
      vim.api.nvim_feedkeys('/', 'n', false)

      -- 2. Força a completação usando a API do blink.cmp
      if cmp.visible() then
        cmp.close()
      end
      cmp.complete()
    end, { noremap = true, silent = true, buffer = true, desc = 'Force completion after / in Clojure' })
  end,
})
