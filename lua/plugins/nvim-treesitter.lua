--return {}
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Opcional mas muito útil
  },
  config = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    local is_windows = vim.loop.os_uname().version:find("Windows") or vim.fn.has("win32") == 1
    local parsers_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"

    local langs = {
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
    }

    -- Se estiver no Windows e a pasta local de parsers existir, aponta as URLs para lá
    if is_windows then
      for _, lang in ipairs(langs) do
        if parser_config[lang] then
          parser_config[lang].install_info.url = parsers_dir .. "/" .. lang
        end
      end
    end

    require("nvim-treesitter.configs").setup({
      ensure_installed = langs,
      auto_install = not is_windows, -- No Windows, faremos manual via local

      install = {
        compilers = is_windows and { "clang" } or nil,
      },

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
