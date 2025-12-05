return {
  "julienvincent/nvim-paredit",
  ft = { "clojure", "fennel", "lisp", "scheme" },
  dependencies = {
    "julienvincent/nvim-paredit-fennel",
  },
  config = function()
    local paredit = require("nvim-paredit")

    paredit.setup({
      use_default_keys = false,
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
    vim.keymap.set({ "n", "v" }, "<leader>e(", function()
      paredit.api.wrap_element_under_cursor("(", ")")
    end, vim.tbl_extend("force", opts, { desc = "Paredit: Wrap with ()" }))

    vim.keymap.set({ "n", "v" }, "<leader>e[", function()
      paredit.api.wrap_element_under_cursor("[", "]")
    end, vim.tbl_extend("force", opts, { desc = "Paredit: Wrap with []" }))

    vim.keymap.set({ "n", "v" }, "<leader>e{", function()
      paredit.api.wrap_element_under_cursor("{", "}")
    end, vim.tbl_extend("force", opts, { desc = "Paredit: Wrap with {}" }))

    -- 2.4. Outros comandos úteis (opcional)
    vim.keymap.set({ "n", "v" }, "<leader>t", function() paredit.api.transpose() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Transpose elements" }))

    vim.keymap.set({ "n", "v" }, "<leader>u", function() paredit.unwrap.unwrap_form_under_cursor() end,
      vim.tbl_extend("force", opts, { desc = "Paredit: Splice sexp/Unwrap" }))

    vim.keymap.set({ "o", "v" }, "af", function() paredit.api.select_around_form() end,
      { desc = "Paredit TextObj: Around form" })
    vim.keymap.set({ "o", "v" }, "if", function() paredit.api.select_in_form() end, { desc = "Paredit TextObj: In form" })

    vim.keymap.set({ "o", "v" }, "aF", function() paredit.api.select_around_top_level_form() end,
      { desc = "Paredit TextObj: Around top-level form" })
    vim.keymap.set({ "o", "v" }, "iF", function() paredit.api.select_in_top_level_form() end,
      { desc = "Paredit TextObj: In top-level form" })

    vim.keymap.set({ "o", "v" }, "ae", function() paredit.api.select_element() end,
      { desc = "Paredit TextObj: Around element" })
    -- Note: 'ie' e 'ae' usam a mesma função select_element, mas o modo 'i'/'a' indica o comportamento
    vim.keymap.set({ "o", "v" }, "ie", function() paredit.api.select_element() end,
      { desc = "Paredit TextObj: In element" })
  end,
}
