return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  config = function()
    -- Colors for markdown viewing
    -- Define custom highlight groups for Markdown headings
    vim.api.nvim_set_hl(0, 'markdownH1', { fg = '#fb4934', bold = true }) -- bright_red
    vim.api.nvim_set_hl(0, 'markdownH2', { fg = '#fabd2f', bold = true }) -- bright_yellow
    vim.api.nvim_set_hl(0, 'markdownH3', { fg = '#b8bb26', bold = true }) -- bright_green
    vim.api.nvim_set_hl(0, 'markdownH4', { fg = '#83a598', bold = true }) -- bright_blue
    vim.api.nvim_set_hl(0, 'markdownH5', { fg = '#d3869b', bold = true }) -- bright_purple
    vim.api.nvim_set_hl(0, 'markdownH6', { fg = '#8ec07c', bold = true }) -- bright_aqua
    require("markview").setup({
      preview = {
        icon_provider = "devicons", -- Use nvim-web-devicons for icons
      },
      highlights = {
        heading = {
          h1 = 'markdownH1',
          h2 = 'markdownH2',
          h3 = 'markdownH3',
          h4 = 'markdownH4',
          h5 = 'markdownH5',
          h6 = 'markdownH6',
        }
      }
    })
  end,

  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  -- },
};
