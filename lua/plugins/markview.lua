return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  priority = 10,
  config = function()
    require("markview").setup({
      preview = {
        icon_provider = "devicons",
      },
    })
  end,
};
-- return {}
