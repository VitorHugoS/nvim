return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Opcional mas muito útil
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Linguagens que você quer instalar automaticamente
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "clojure",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "java",
        "markdown",
        "markdown_inline",
      },

      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    })
  end,
}
