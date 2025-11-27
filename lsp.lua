local lsp = {}

function lsp.setup()
  local lsp_default_capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Enable file creating and renaming
  lsp_default_capabilities.workspace.workspaceEdit.documentChanges = true

  -- Lua LS
  vim.lsp.config['lua_ls'] = {
    cmd = { 'lua-language-server' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  -- Clojure LS
  vim.lsp.config['clojure_lsp'] = {
    capabilities = lsp_default_capabilities,
    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider.full = true
    end,
  }

  ---------------------------------------------------------------------------
  -- LSP keymaps (somente quando o cliente está anexado ao buffer)
  ---------------------------------------------------------------------------
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(ev)

      ----------------------------------------------------------------------
      -- 🔥 IMPORTANTE: Remover todos os bindings automáticos que começam com GR
      -- Isso garante que NADA do LSP quebre o operador nativo "gr".
      ----------------------------------------------------------------------
      local function safe_del(lhs)
        pcall(vim.keymap.del, "n", lhs, { buffer = ev.buf })
      end

      safe_del("gr")
      safe_del("gri")
      safe_del("grr")
      safe_del("grn")
      safe_del("grR")
      safe_del("grN")

      ----------------------------------------------------------------------
      -- Habilitar omnicompletion
      ----------------------------------------------------------------------
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      ----------------------------------------------------------------------
      -- Buffer-local LSP keymaps (todos com <leader> para evitar conflitos)
      ----------------------------------------------------------------------
      local opts = { buffer = ev.buf }

      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<leader>gh', vim.lsp.buf.hover, opts)

      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)

      vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)

      -- Format
      vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })

  -- Enable servers
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('clojure_lsp')
end

return lsp
