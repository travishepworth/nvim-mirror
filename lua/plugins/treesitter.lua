return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = { "OXY2DEV/markview.nvim" },
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
