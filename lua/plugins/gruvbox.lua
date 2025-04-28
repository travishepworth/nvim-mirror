return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      contrast = "soft",
      vim.cmd.colorscheme('gruvbox'),

      -- Define custom highlight groups for Markdown headings
      vim.api.nvim_set_hl(0, 'markdownH1', { fg = '#fb4934', bold = true }), -- bright_red
      vim.api.nvim_set_hl(0, 'markdownH2', { fg = '#d3869b', bold = true }), -- bright_red
      vim.api.nvim_set_hl(0, 'markdownH3', { fg = '#fabd2f', bold = true }), -- bright_green
      vim.api.nvim_set_hl(0, 'markdownH4', { fg = '#83a598', bold = true }), -- bright_blue
      vim.api.nvim_set_hl(0, 'markdownH5', { fg = '#b8bb26', bold = true }), -- bright_purple
      vim.api.nvim_set_hl(0, 'markdownH6', { fg = '#8ec07c', bold = true }), -- bright_aqua

      -- Link Treesitter highlight groups to custom Markdown heading highlights
      vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { link = 'markdownH1' }),
      vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { link = 'markdownH2' }),
      vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { link = 'markdownH3' }),
      vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { link = 'markdownH4' }),
      vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { link = 'markdownH5' }),
      vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { link = 'markdownH6' }),

      -- Other highlight settings
      vim.cmd([[highlight NormalFloat guibg=#282828]]),
      vim.cmd([[highlight LspInfoBorder guifg=#ebdbb2]]),
      vim.cmd([[highlight NoiceCmdlinePopup guibg=#282828]]),
      vim.cmd([[highlight NoiceCmdlinePopupBorder guibg=#282828]]),
      vim.cmd([[highlight NoiceCmdlinePopupBorder guifg=#83a598]]),

    })
  end,
}
