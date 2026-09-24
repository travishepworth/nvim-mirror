-- Colorscheme follows the axiom shell theme (see lua/axiom_theme.lua)
return {
  "echasnovski/mini.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("axiom_theme").reload()
  end,
}
