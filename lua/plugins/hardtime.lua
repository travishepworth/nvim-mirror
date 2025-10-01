return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  enabled = true,
  opts = {
    restricted_keys = {
      ["j"] = false,
      ["k"] = false,
    },
    disabled_keys = {
      ["<Up>"] = false,
      ["<Down>"] = false,
      ["<Left>"] = false,
      ["<Right>"] = false,
    }
  },
}
-- return {}
