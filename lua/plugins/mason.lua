return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- servers to setup
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        ts_ls = {},
        pylsp = {},
        eslint = {},
        jdtls = {},
        clojure_lsp = {}
      }

      -- mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      for server, opts in pairs(servers) do
        opts.capabilities = capabilities
        vim.lsp.config(server, opts) -- configure the server
        vim.lsp.enable(server)       -- enable it globally
      end
      vim.diagnostic.config({
        virtual_text = true,
        underline = true
      })
      -- basic keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format buffer (LSP)" })
    end,
  },
}
