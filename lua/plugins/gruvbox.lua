-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
--     require("gruvbox").setup({
--       terminal_colors = true,
--       contrast = "soft",
--       vim.cmd.colorscheme('gruvbox'),
--       vim.cmd([[highlight NormalFloat guibg=#282828]]),
--       vim.cmd([[highlight LspInfoBorder guifg=#ebdbb2]]),
--       vim.cmd([[highlight NoiceCmdlinePopup guibg=#282828]]),
--       vim.cmd([[highlight NoiceCmdlinePopupBorder guibg=#282828]]),
--       vim.cmd([[highlight NoiceCmdlinePopupBorder guifg=#83a598]]),
--
--     })
--   end,
-- }

return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_enable_italic = true
    vim.cmd.colorscheme('gruvbox-material')
  end
}
