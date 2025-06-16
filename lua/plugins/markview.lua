return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  config = function()
    -- Colors for markdown viewing
    require("markview").setup({
      preview = {
        icon_provider = "devicons", -- Use nvim-web-devicons for icons
      },
    })
  end,
};
-- return {}
