return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            -- Follows the colorscheme's warning colour
            color = function()
              local fg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).fg
              return fg and { fg = string.format("#%06x", fg) } or nil
            end,
          }
        },
      },
      options = {
        -- theme = 'gruvbox_dark',
        theme = 'auto',
      }
    })
  end
}
