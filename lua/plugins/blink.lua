return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp-signature-help',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- auto_insert = false
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Scroll down in documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Scroll up in documentation
      },

      sources = cmp.config.sources({
        { name = 'nvim_lsp', keyword_length = 0, priority = 1000 },
        { name = 'luasnip',  priority = 100 },
        { name = 'path' },
      }, {
        { name = 'buffer', priority = 10 },
      }),

      completion = {
        completeopt = 'menu,menuone,noinsert', -- preselect = true, auto_insert = false
      },

      formatting = {
        fields = { 'kind', 'abbr' },
      },

      window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder",
          filetype = "markdown",
        },
      },

      experimental = {
        ghost_text = false, -- You had this commented out
      },

      performance = {
        max_view_entries = 9, -- max_items = 9
      },
    })
  end,
}
