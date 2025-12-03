return {
  "julienvincent/nvim-paredit",
  ft = { "clojure", "fennel", "lisp", "scheme" }, -- Carrega só para Lisps
  dependencies = {
    "julienvincent/nvim-paredit-fennel",          -- Opcional, mas recomendado
  },
  config = function()
    local paredit = require("nvim-paredit")
    paredit.setup({
      -- Ativa em quais filetypes
      filetypes = { "clojure", "fennel", "lisp", "scheme" },

      -- Configurações básicas
      indent = {
        enabled = true,
        indentor = require("nvim-paredit.indentation.native").indentor,
      },

      -- Keymaps principais (você pode customizar)
    })
     vim.keymap.set("n", "<leader>>", paredit.api.slurp_forwards, { desc = "Slurp forwards" })
    vim.keymap.set("n", "<leader><lt>", paredit.api.barf_forwards, { desc = "Barf forwards" })
    vim.keymap.set("n", "<leader>>>", paredit.api.slurp_backwards, { desc = "Slurp backwards" })
    vim.keymap.set("n", "<leader><<", paredit.api.barf_backwards, { desc = "Barf backwards" })
    
    vim.keymap.set("n", "<leader>o", paredit.api.raise_form, { desc = "Raise form" })
    vim.keymap.set("n", "<leader>O", paredit.api.raise_element, { desc = "Raise element" })
    
    -- Wrap precisa ser função
    vim.keymap.set("n", "<leader>w(", function()
      paredit.api.wrap_element_under_cursor("(", ")")
    end, { desc = "Wrap with ()" })
    
    vim.keymap.set("n", "<leader>w[", function()
      paredit.api.wrap_element_under_cursor("[", "]")
    end, { desc = "Wrap with []" })
    
    vim.keymap.set("n", "<leader>w{", function()
      paredit.api.wrap_element_under_cursor("{", "}")
    end, { desc = "Wrap with {}" })
  end,
}
