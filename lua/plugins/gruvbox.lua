-- Picked by axiom_theme.lua (gruvbox-dark, gruvbox-light)
return {
  "ellisonleao/gruvbox.nvim",
  lazy = true,
  opts = {
    terminal_colors = true,
    contrast = "medium",
  },
  init = function()
    -- Markdown heading colours (dark palette only)
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "gruvbox",
      callback = function()
        if vim.o.background ~= "dark" then
          return
        end
        local headings = { "#fabd2f", "#d3869b", "#fe8019", "#fb4934", "#b8bb26", "#83a598" }
        for level, color in ipairs(headings) do
          vim.api.nvim_set_hl(0, "markdownH" .. level, { fg = color, bold = true })
          vim.api.nvim_set_hl(0, "@markup.heading." .. level .. ".markdown", { link = "markdownH" .. level })
        end
      end,
    })
  end,
}
