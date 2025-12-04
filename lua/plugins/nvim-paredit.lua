return {
  "julienvincent/nvim-paredit",
  ft = { "clojure", "fennel", "lisp", "scheme" },
  dependencies = {
    "julienvincent/nvim-paredit-fennel",
  },
  config = function()
    local paredit = require("nvim-paredit")

    -- 1. SETUP DO PAREDIT
    -- Desative os mapeamentos padrão para evitar conflitos (como >)
    paredit.setup({
      use_default_keys = false, -- <--- CHAVE PARA O SEU PROBLEMA
      filetypes = { "clojure", "fennel", "scheme", "lisp", "janet" },
      languages = {
        clojure = { whitespace_chars = { " ", "," } },
        fennel = { whitespace_chars = { " ", "," } },
      },
      cursor_behaviour = "auto",
      dragging = { auto_drag_pairs = true },
      indent = {
        enabled = false,
        indentor = require("nvim-paredit.indentation.native").indentor,
      },
    })

    local opts = { noremap = true, silent = true }

    vim.keymap.set({ "n", "v" }, "<leader>s", function() paredit.api.slurp_forwards() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Slurp forwards" }))
    vim.keymap.set({ "n", "v" }, "<leader>b", function() paredit.api.barf_forwards() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Barf forwards" }))
    vim.keymap.set({ "n", "v" }, "<leader>S", function() paredit.api.slurp_backwards() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Slurp backwards" }))
    vim.keymap.set({ "n", "v" }, "<leader>B", function() paredit.api.barf_backwards() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Barf backwards" }))

    -- 2.2. Raise (Eleva uma forma)
    vim.keymap.set({ "n", "v" }, "<leader>o", function() paredit.api.raise_form() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Raise form" }))
    vim.keymap.set({ "n", "v" }, "<leader>O", function() paredit.api.raise_element() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Raise element" }))

    -- 2.3. Wrap
    vim.keymap.set({ "n", "v" }, "<leader>w(", function()
      paredit.api.wrap_element_under_cursor("(", ")")
    end, vim.tbl_extend("force", opts, { desc = "Paredit: Wrap with ()" }))

    vim.keymap.set({ "n", "v" }, "<leader>w[", function()
      paredit.api.wrap_element_under_cursor("[", "]")
    end, vim.tbl_extend("force", opts, { desc = "Paredit: Wrap with []" }))

    vim.keymap.set({ "n", "v" }, "<leader>w{", function()
      paredit.api.wrap_element_under_cursor("{", "}")
    end, vim.tbl_extend("force", opts, { desc = "Paredit: Wrap with {}" }))

    -- 2.4. Outros comandos úteis (opcional)
    vim.keymap.set({ "n", "v" }, "<leader>t", function() paredit.api.transpose() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Transpose elements" }))

    vim.keymap.set({ "n", "v" }, "<leader>u", function() paredit.unwrap.unwrap_form_under_cursor() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Splice sexp/Unwrap" }))

    -- Você pode adicionar seus comandos de movimento aqui se quiser
    -- Exemplo: W para mover para a próxima cabeça de elemento
    -- vim.keymap.set({ "n", "x", "o", "v" }, "W", function() paredit.api.move_to_next_element_head() end, opts)
  end,
}
