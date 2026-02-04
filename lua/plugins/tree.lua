return {
  "nvim-tree/nvim-tree.lua",
  version = "*", -- Pin to a version or use '*' for latest
  lazy = false, -- nvim-tree should load at startup
  config = function()
    require("nvim-tree").setup {
      -- add your options here
      filters = {
        dotfiles = true,
      },
      -- other settings can be found in the documentation
    }
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, but recommended for icons
  },
}
