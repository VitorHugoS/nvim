return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },

  version = '1.*',
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'normal'
    },

    completion = {
      accept = {
        dot_repeat = true,
        create_undo_point = true,
        auto_brackets = {
          enabled = false,
        },
      },

      keyword = {
        range = "prefix",
      },
      list = {
        max_items = 9,
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },

      menu = {
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind" }
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
      --ghost_text = { enabled = true },

    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        buffer = {
          enabled = true,
        },
        snippets = {
          enabled = true,
        },
        lsp = {
          min_keyword_length = 1,
          score_offset = 100,
        },
      },

    },

    signature = { enabled = true },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      frecency = {
        enabled = true,
      },
      use_proximity = true,
    }
  },
  opts_extend = { "sources.default" }
}
